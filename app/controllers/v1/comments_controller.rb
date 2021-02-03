# frozen_string_literal: true
class V1::CommentsController < ApplicationController
  before_action :get_parent

  def index
    render json: render_response(resource: @parent.comments), status: :ok
  rescue => exception
    render_exception exception
  end

  def create
  end

  def update
  end

  def archive
  end

end
