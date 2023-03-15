# frozen_string_literal: true

class CommentBroadcastService
  attr_reader :comment, :user, :project

  def initialize(comment, user)
    @comment = comment
    @user = user
    @project = comment.project
  end

  def call
    if comment.errors.present?
      broadcast_error(comment.errors.full_messages.join)
    else
      broadcast_comment
    end
  end

  private

  def broadcast_comment
    ActionCable.server.broadcast(
      "comments_for_#{project.id}",
      { comment: render(partial: "comments/comment", locals: { comment: comment }),
        user: user.id, status: project.status }
    )
  end

  def broadcast_error(message)
    ActionCable.server.broadcast(
      "comments_for_#{project.id}",
      { error: message,
        user: user.id }
    )
  end

  def render(*args)
    ApplicationController.renderer.render(*args)
  end
end
