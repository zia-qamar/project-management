# frozen_string_literal: true

class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @comment = Comment.create(comment_params)
    CommentBroadcastService.new(@comment, current_user).call
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :project_id).merge(user: current_user)
  end
end
