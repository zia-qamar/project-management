# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  describe "#create_status_comment" do
    let(:from_status) { "pending" }
    let(:comment) { Comment.create_status_comment(from_status, user, project) }

    it "creates a new comment" do
      expect { comment }.to change(Comment, :count).by(1)
    end

    it "sets the content correctly" do
      expect(comment.content).to eq("Project status changed from #{from_status} to #{project.status}.")
    end

    it "sets the user correctly" do
      expect(comment.user).to eq(user)
    end

    it "sets the project correctly" do
      expect(comment.project).to eq(project)
    end

    it "sets the comment type to status_change" do
      expect(comment.status_change?).to be true
    end
  end
end
