# frozen_string_literal: true

class V1::SheikhsController < ApplicationController
  include V1::SheikhsHelper

  def index
  end

  def create
    authorize User, :admin?
    @sheikh = Sheikh.new(sheikh_params)
    if @sheikh.save
      render json: sheikh_serializer, status: :ok
    else
      render json: { message: @sheikh.errors.messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end

  def show
  end

  def update
    authorize User, :admin?
    @sheikh = Sheikh.find(params[:id])
    if @sheikh.update(sheikh_params)
      render json: sheikh_serializer, status: :ok
    else
      render json: { message: @sheikh.errors.messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end

  def destroy
  end

  private
    def sheikh_params
      params.permit(:names, :tel, :address, :role, :language, :avatar)
    end

    def sheikh_serializer
      avatar_path = url_for(@sheikh.avatar) if @sheikh.avatar.attached?
      @sheikh.language = language_full_name(@sheikh.language)
      @sheikh.attributes.merge(avatar: avatar_path).except("updated_at")
    end
end
