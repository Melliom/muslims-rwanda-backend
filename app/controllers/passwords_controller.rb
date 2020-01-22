# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  private
    def respond_with(resource, _opts = {})
      return render json: {
        message: "Something went wrong",
        details: resource.errors.full_messages,
      }, status: :bad_request if resource.try(:errors).present?

      if resource.blank?
        return render json: {
          message: "Email sent, please check your inbox and follow the instruction",
        }, status: :ok
      else
        render json: current_user, status: :ok
      end
    end
end
