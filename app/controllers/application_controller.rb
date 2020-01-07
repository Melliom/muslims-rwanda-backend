# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def render_resource(resource)
    if resource.errors.empty?
      render json: current_user
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    errors = resource.errors.full_messages
    status =  errors.include?("Email has already been taken") ? 409 : 400
    render json: {
          message: "Something went wrong",
          details: errors,
      }, status: status
  end
end
