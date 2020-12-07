# frozen_string_literal: true

class V1::MosquesController < ApplicationController
  before_action :admin?

  def index
    @mosques = Mosque.all
    render json: @mosques, status: :ok
  rescue => exception
    render_exception exception
  end

  def create
    @mosque = Mosque.new(mosque_params)
    if @mosque.save
      render json: @mosque, status: :ok
    else
      render json: { message: @mosque.errors.messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end

  def show
    @mosque = Mosque.find(params[:id])
    render json: @mosque, status: :ok
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end



  private
    def mosque_params
      params.permit(:name, :lng, :lat, :address, :momo_number, :cashpower, :size)
    end
end
