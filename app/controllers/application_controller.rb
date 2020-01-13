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

  def generate_token(email)
    exp = Time.now.to_i + 2 * (3600 * 24)
    payload = { data: email, exp: exp }
    JWT.encode(payload, ENV["DEVISE_SECRET_KEY"], "HS256")
  end

  def decode_token(token)
    decoded_token = JWT.decode token, ENV["DEVISE_SECRET_KEY"], true, { algorithm: "HS256" }
    {
      status: true,
      token: decoded_token
    }
  rescue JWT::ExpiredSignature
    {
      status: false,
      message: "Token expired"
    }
  rescue JWT::VerificationError
    {
      status: false,
      message: "Invalid token"
    }
  end
end
