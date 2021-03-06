# frozen_string_literal: true

class V1::SheikhsController < ApplicationController
  include V1::SheikhsHelper
  after_action { pagy_headers_merge(@pagy) if @pagy && !Rails.env.test? }

  def index
    authorize User, :admin?
    @pagy, @sheikhs = if params[:search]
      pagy(Sheikh.with_attached_avatar.search(params[:search]), page: 1)
    else
      pagy(Sheikh.all_active.with_attached_avatar)
    end
    render json: render_response(resource: sheikh_all_serializer), status: :ok
  rescue => exception
    render_exception exception
  end

  def create
    authorize User, :admin?
    @sheikh = Sheikh.new(sheikh_params)
    if @sheikh.valid?
      @sheikh.avatar = params[:avatar]
      if @sheikh.save
        render json: sheikh_serializer, status: :ok
      else
        render json: { message: @sheikh.errors.messages }, status: :bad_request
      end
    else
      render json: { message: @sheikh.errors.messages }, status: :bad_request
    end
  rescue => exception
    render_exception exception
  end

  def show
    authorize User, :admin?
    @sheikh = Sheikh.find(params[:id])
    render json: sheikh_serializer, status: :ok
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
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
    authorize User, :admin?
    @sheikh = Sheikh.find(params[:id])
    if @sheikh.inactive!
      render json: { message: "Sheikh successfully archived" }, status: :ok
    else
      render json: { message: @sheikh.errors.messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end

  def search
    authorize User, :admin?
    @result = Sheikh.search(params[:keywords])
    render json: sheikh_all_serializer(@result), status: :ok
  rescue ActiveRecord::RecordNotFound => exception
    render_exception exception, :not_found
  rescue => exception
    render_exception exception
  end

  private
    def sheikh_params
      params.permit(:names, :telephone, :address, :role, :language)
    end

    def sheikh_serializer(sheikh = @sheikh)
      avatar_path = url_for(sheikh.avatar) if sheikh.avatar.attached?
      sheikh.language = language_full_name(sheikh.language)
      sheikh.attributes.merge(avatar: avatar_path).except("updated_at")
    end

    def sheikh_all_serializer(sheikhs = @sheikhs)
      if sheikhs
        sheikhs.map do |sheikh|
          sheikh_serializer(sheikh)
        end
      end
    end
end
