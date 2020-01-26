# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  private
    def respond_with(resource, _opts = {})
      if resource.try(:messages).blank?
        sign_in(resource)
        render json: {
          message: "Email confirmed!",
          data: current_user
        }, status: :ok
      else
        render json: {
         message: "Something went wrong",
         details: resource.full_messages,
       }, status: :bad_request
      end
    end
end
