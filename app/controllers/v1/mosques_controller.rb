# frozen_string_literal: true

class V1::MosquesController < ApplicationController
  before_action :admin?

  def index
    @mosques = Mosque.all_active
    render json: render_response(resource: @mosques), status: :ok
  rescue => exception
    render_exception exception
  end

  def create
    @mosque = Mosque.new(mosque_params)
    if @mosque.save
      render json: render_response(resource: @mosque), status: :ok
    else
      render json: { message: @mosque.errors.messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end

  def show
    @mosque = Mosque.find_active(params[:id])
    render json: render_response(resource: @mosque), status: :ok
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end


  def update
    @mosque = Mosque.find_active(params[:id])
    if @mosque.update(mosque_params)
      render json:
        render_response(
          message: "Mosque updated successfully",
          resource: @mosque
        ),
        status: :ok
    else
      render json: { message: @mosque.errors.messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end

  def destroy
    @mosque = Mosque.find_active(params[:id])
    @mosque.archived = true
    if @mosque.save
      render json:
        render_response(
          message: "Mosque #{@mosque.name} deleted successfully"
        ),
        status: :ok
    else
      render json: { message: @mosque.errors.messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end


  def add_imam
    mosque  = Mosque.all_active.find(params[:mosque_id])
    if mosque.imam = Sheikh.find(params[:sheikh_id])
      render json:
        render_response(
          message: "Imam added successfully"
        ),
        status: :ok
    else
      render json: { message: mosque.errors.messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end

  private
    def mosque_params
      params.permit(:name, :lng, :lat, :address, :momo_number, :cashpower, :size)
    end
end
