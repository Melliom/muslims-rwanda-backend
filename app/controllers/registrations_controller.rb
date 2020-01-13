# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :verify_authenticity_token, only: [:create, :create_admin]
  before_action :authenticate!, only: :create_admin


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

  def create_admin
    email = params[:email]
    return render json: { message: "Email must be provided" }, status: :bad_request if email.empty?
    token = generate_token(email)
    admin = User.find_by(email: email)

    # authorize super admin
    authorize User, :super_admin?
    if admin.blank?
      @admin = User.new(email: email, password: SecureRandom.hex, confirmation_token: token, confirmed_at: Time.zone.now)
      @admin.admin!

      if @admin.save
        UserMailer.with(email: email, token: token).invite_admin_mail.deliver_later
        render json: { message: "Email successfuly sent to #{email}" }, status: :ok
      else
        render json: { message: @admin.errors.full_messages }, status: :bad_request
      end
    else
      render json: { message: "Email already exists" }, status: :bad_request
    end
  rescue => exception
    render json: { message: exception }, status: exception.is_a?(Pundit::NotAuthorizedError) ? :unauthorized : :bad_request
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :uid, :provider, :avatar)
  end

  private
    def authenticate!
      return render json: { message: "Unauthorized request, you must login first" }, status: :unauthorized unless user_signed_in?
    end
end
