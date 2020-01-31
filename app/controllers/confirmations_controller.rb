# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  private
    def respond_with(resource, _opts = {})
      if resource.try(:messages).blank? && resource.try(:errors).blank?

        if resource.present?
          sign_in(resource)
          return render json: {
            message: "Email confirmed!",
            data: current_user
          }, status: :ok
        end

        render json: {
          message: "Confirmation instruction sent to your email",
        }, status: :ok

      else
        render json: {
         message: "Something went wrong",
         details: resource.try(:errors) ? resource.errors.full_messages : resource.full_messages,
       }, status: :bad_request
      end
    end
end
