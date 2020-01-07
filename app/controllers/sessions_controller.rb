# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  private
    def respond_with(resource, _opts = {})
      render json: resource
    end
    def respond_to_on_destroy
      head :ok
    end
end
