# frozen_string_literal: true

class Comment < ApplicationRecord
  validates_presence_of :content

  belongs_to :user
  belongs_to :project

  enum comment_type: { comment: 0, status_change: 1 }

  def self.create_status_comment(from_status, user, project)
    message = "Project status changed from #{from_status} to #{project.status}."
    create(content: message, user_id: user.id, project: project, comment_type: :status_change)
  end
end
