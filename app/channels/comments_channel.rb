# frozen_string_literal: true

class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_for_#{params[:project_id]}"
  end
end
