# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :lower_user

  def initialize(user, lower_user)
    @user = user
    @lower_user = lower_user
  end

  def super_admin?
    raise Pundit::NotAuthorizedError, "You are not authorized to perform this action." unless @user.super_admin?
    true
  end

  def admin?
    raise Pundit::NotAuthorizedError, "You are not authorized to perform this action." unless @user.super_admin? || @user.admin?
    true
  end
end
