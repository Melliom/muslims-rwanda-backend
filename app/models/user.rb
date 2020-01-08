# frozen_string_literal: true

class User < ApplicationRecord
  enum roles: {
    user: 0,
    admin: 1,
    super_admin: 2,
  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist


  def jwt_payload
    {
      'id': id,
      'email': email,
      'avatar': avatar
    }
  end
end
