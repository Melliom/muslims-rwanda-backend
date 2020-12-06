# frozen_string_literal: true

class V1::MosquesController < ApplicationController
  def index
    authorize User, :admin?
    @mosques = Mosque.all
    render json: @mosques, status: :ok
  rescue => exception
    render_exception exception
  end

  def create
    authorize User, :admin?
    @mosque = Mosque.new(mosque_params)
    if @mosque.save
      render json: @mosque, status: :ok
    else
      render json: { message: @mosque.errors.messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end


  private
    def mosque_params
      params.permit(:name, :lng, :lat, :address, :momo_number, :cashpower, :size)
    end
end
