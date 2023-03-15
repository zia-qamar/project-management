# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    { title: "Test Project", description: "This is a test project.", user: user }
  end

  let(:invalid_attributes) { { title: "" } }

  before(:each) do
    sign_in(user)
  end

  describe "GET #index" do
    it "returns a success response" do
      Project.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      project = Project.create! valid_attributes
      get :show, params: { id: project.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      project = Project.create! valid_attributes
      get :edit, params: { id: project.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Project" do
        expect do
          post :create, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it "redirects to the created project" do
        post :create, params: { project: valid_attributes }
        expect(response).to redirect_to(Project.last)
      end
    end

    context "with invalid params" do
      it "returns a unprocessable response" do
        post :create, params: { project: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { title: "Updated Project", description: "This is a test project." }
      end

      it "updates the requested project" do
        project = Project.create! valid_attributes
        put :update, params: { id: project.to_param, project: new_attributes }
        project.reload
        expect(project.title).to eq new_attributes[:title]
      end

      it "redirects to the project" do
        project = Project.create! valid_attributes
        put :update, params: { id: project.to_param, project: valid_attributes }
        expect(response).to redirect_to(project)
      end
    end

    context "with invalid params" do
      it "returns a unprocessable response" do
        project = Project.create! valid_attributes
        put :update, params: { id: project.to_param, project: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect do
        delete :destroy, params: { id: project.to_param }
      end.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete :destroy, params: { id: project.to_param }
      expect(response).to redirect_to(projects_url)
    end
  end

  describe "#update_status" do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:comment) { double("comment") }

    before { sign_in user }

    context "when update is successful" do
      before do
        allow(Comment).to receive(:create_status_comment).and_return(comment)
        allow(CommentBroadcastService).to receive(:new).and_return(double(call: true))
        patch :update_status, params: { id: project.id, status: :in_progress }, xhr: true
      end

      it "updates the project status" do
        expect(project.reload.status).to eq("in_progress")
      end

      it "creates a new status change comment" do
        expect(Comment).to have_received(:create_status_comment).with("pending", user, project)
      end

      it "calls the CommentBroadcastService" do
        expect(CommentBroadcastService).to have_received(:new).with(comment, user)
      end

      it "responds with a json message" do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ "project_status" => "in_progress", "msg" => "Status updated" })
      end
    end
  end
end
