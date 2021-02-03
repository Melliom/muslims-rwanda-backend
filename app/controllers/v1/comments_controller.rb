# frozen_string_literal: true
class V1::CommentsController < ApplicationController
  before_action :get_parent

  def index
    render json: render_response(resource: @parent.comments.non_threads), status: :ok
  rescue => exception
    render_exception exception
  end

  def create
    @comment = @parent.comments.new(comment_params)
    if @comment.save
      render json: render_response(message: @comment.is_thread? ? "Thread created" : " Comment created", resource: @comment), status: :ok
    else
      render_exception @comment.errors.full_messages
    end
  rescue => exception
    render_exception exception
  end

  def update
  end

  def archive
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :is_thread)
  end
  

end
