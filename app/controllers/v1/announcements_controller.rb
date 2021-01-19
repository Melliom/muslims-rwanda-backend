# frozen_string_literal: true

class V1::AnnouncementsController < ApplicationController
  before_action :admin?, except: :index

  def index
    @announcements = Announcement.all_active
    render json: render_response(resource: @announcements), status: :ok
  rescue => exception
    render_exception exception
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      render json: render_response(message: "Annoucement created", resource: @announcement), status: :ok
    else
      render_exception @announcement.errors.full_messages
    end
  rescue => exception
    render_exception exception
  end

  def update
    @announcement = Announcement.find_active(params[:id])
    if @announcement.update(announcement_params)
      render json: render_response(resource: @announcement), status: :ok
    else
      render_exception @announcement.errors.full_messages
    end
  rescue => exception
    render_exception exception
  end


  def show
    @announcement = Announcement.find_active(params[:id])
    render json: render_response(resource: @announcement), status: :ok
  rescue => exception
    render_exception exception
  end
  

  def destroy
    @announcement = Announcement.find_active(params[:id])
    if @announcement.archived!
      render json: render_response(message: "Announcement #{@announcement.title} deleted successfully"), status: :ok
    else
      render_exception exception
    end
  rescue => exception
    render_exception exception
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :description, tags: [])
    end
end
