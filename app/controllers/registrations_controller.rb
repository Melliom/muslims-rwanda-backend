# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :verify_authenticity_token, only: :create

  def create
    build_resource(sign_up_params)

    if resource.uid
      user = User.where(email: params[:user][:email]).first
      resource.confirmed_at = Time.zone.now
      # using ruby safe navigation user&.name == user && user.name
      if user&.uid == resource.uid
        sign_in(user)
        return render_resource(resource)
      end
    end
    resource.save && sign_in(resource)
    render_resource(resource)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :uid, :provider, :avatar)
  end
end
