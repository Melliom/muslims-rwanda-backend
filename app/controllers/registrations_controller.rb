# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :authenticate!, only: :create_admin
  skip_before_action :verify_authenticity_token, only: [:create, :create_admin, :register_admin]


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
    render_exception exception
  end

  def verify_admin_token
    token = params[:token]
    payload = decode_token(token)
    respond_to do |format|
      # render json: { email: payload[:data] }, status: :success if payload
      format.json { render json: { email: payload[:data] }, status: :ok }
      format.html { render template: "single_page/index" }
    end
  rescue => exception
    render json: { message: exception }, status: :bad_request
  end


  def register_admin
    new_admin = User.find_by(email: params[:email])
    return render json: { message: "Admin not found with that email" }, status: :not_found if new_admin.blank?
    if new_admin.admin? && new_admin.update(admin_params)
      sign_in(new_admin)
      return render_resource(new_admin)
    end
    render json: { message: new_admin.errors.present? ? new_admin.errors.full_messages : "User not an admin" }, status: :bad_request
  rescue => exception
    render json: { message: exception }, status: :bad_request
  end


  def sign_up_params
    params.require(:user).permit(:email, :password, :uid, :provider, :avatar)
  end

  private
    def authenticate!
      return render json: { message: "Unauthorized request, you must login first" }, status: :unauthorized unless user_signed_in?
    end

    def admin_params
      params.require(:admin).permit(:password, :names, :sex)
    end
end
