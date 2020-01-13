# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "muslim-rwanda@mra.com"

  def invite_admin_mail
    @email = params[:email]
    token = params[:token]
    base_url  = Rails.env.development? ? ENV["DEV_URL"] : ENV["PRODUCTION_URL"]
    @url = "#{base_url}/admin-invite?token=#{token}"
    mail(to: @email, subject: "You have been invited to join Muslim Rwanda App")
  end
end
