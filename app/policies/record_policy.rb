# frozen_string_literal: true
class RecordPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.admin? || user.admin? || (not record.published?)
  end
end
