# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:valid_attributes) { { comment: { content: "Test comment", project_id: project.id, user: user.id } } }
    let(:invalid_attributes) { { comment: { content: "", project_id: project.id } } }

    context "when the user is authenticated" do
      before { sign_in user }

      context "with valid parameters" do
        it "creates a new comment" do
          expect do
            post :create, params: valid_attributes
          end.to change(Comment, :count).by(1)
        end

        it "redirects to the project" do
          post :create, params: valid_attributes
          expect(response).to have_http_status(204)
        end
      end

      context "with invalid parameters" do
        it "does not create a new comment" do
          expect do
            post :create, params: invalid_attributes
          end.to_not change(Comment, :count)
        end
      end
    end
  end
end
