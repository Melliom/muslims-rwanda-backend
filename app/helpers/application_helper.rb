# frozen_string_literal: true

module ApplicationHelper
  def render_exception(exception)
    render json: { message: exception }, status: exception.is_a?(Pundit::NotAuthorizedError) ? :unauthorized : :bad_request
  end
end
