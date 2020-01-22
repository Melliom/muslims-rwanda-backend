# frozen_string_literal: true

require "rails_helper"

RSpec.describe PasswordsController, type: :controller do
  tests PasswordsController
  include Devise::TestHelpers


  describe "Password Reset" do
    before :all do
      @user = FactoryBot.create(:user)
    end

    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    after :all do
      @user.destroy
    end


    context "When Requesting" do
      it "should fail if the email is not found" do
        post :create, params: {
          user: { email: "teste@mail.com" }
        }
        expect(json_body[:details].first).to eq("Email not found")
      end

      it "should succeed sendind the instruction" do
        post :create, params: {
          user: { email: @user.email }
        }
        expect(json_body[:message]).to eq("Email sent, please check your inbox and follow the instruction")
      end
    end

    context "When Confirming" do
      it "should fail if the token is invalid" do
        patch :update, params: {
          user: {
            reset_password_token: "_wrong_token",
            "password": "newpassword",
            "password_confirmation": "newpassword"
          }
        }
        expect(json_body[:details].first).to eq("Reset password token is invalid")
      end

      it "should fail if the password is invalid #too-short" do
        reset_password_token = @user.send_reset_password_instructions
        patch :update, params: {
          user: {
            reset_password_token: reset_password_token,
            "password": "n",
            "password_confirmation": "n"
          }
        }
        expect(json_body[:details].first).to eq("Password is too short (minimum is 6 characters)")
      end

      it "should fail if the passwords do not match" do
        reset_password_token = @user.send_reset_password_instructions
        patch :update, params: {
          user: {
            reset_password_token: reset_password_token,
            "password": "donotmatch",
            "password_confirmation": "really-something-else"
          }
        }
        expect(json_body[:details].first).to eq("Password confirmation doesn't match Password")
      end

      it "should succeed" do
        reset_password_token = @user.send_reset_password_instructions
        patch :update, params: {
          user: {
            reset_password_token: reset_password_token,
            "password": "newpassword",
            "password_confirmation": "newpassword"
          }
        }
        expect(json_body).to have_key(:email)
        expect(json_body[:email]).to eq(@user.email)
      end
    end
  end
end
