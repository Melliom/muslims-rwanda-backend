# frozen_string_literal: true

class V1::AnnouncementsController < ApplicationController
  before_action :admin?, except: :index

  def index
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      render json: render_response(message: "Annoucement created", resource: @announcement), status: :ok
    else
      render json: { message: @announcement.errors.full_messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end

  def update
  end

  def archive
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :description, tags: [])
    end
end
