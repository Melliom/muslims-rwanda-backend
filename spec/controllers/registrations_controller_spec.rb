# frozen_string_literal: true

require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  login_user

  describe "User" do
    it "should have a current user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end
end
