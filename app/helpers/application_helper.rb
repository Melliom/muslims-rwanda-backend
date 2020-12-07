# frozen_string_literal: true

module ApplicationHelper
  def render_exception(exception, status = :bad_request)
    status = :unauthorized if exception.is_a?(Pundit::NotAuthorizedError)
    render json: { message: exception }, status: status
  end

  def render_response(message: nil, resource:)
    { message: message, data: resource }.compact
  end
end
