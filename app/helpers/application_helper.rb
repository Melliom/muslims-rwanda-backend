# frozen_string_literal: true

module ApplicationHelper
  def render_exception(exception, status = :bad_request)
    status = case exception
             when Pundit::NotAuthorizedError
               :unauthorized
             when ActiveRecord::RecordNotFound
               :not_found
             else
               status
    end
    exception = exception.to_s.split("[WHERE")[0]&.strip if exception.to_s&.include? "[WHERE"
    render json: { message: exception }, status: status
  end

  def render_response(message: nil, resource: nil, meta: nil)
    { message: message&.capitalize, data: resource, meta: meta }.compact
  end
end
