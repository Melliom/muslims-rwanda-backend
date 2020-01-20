# frozen_string_literal: true

require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  describe "User" do
    login_user
    it "should have a current user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end

  describe "Super-admin" do
    login_super_admin
    context "when creating an admin" do
      context "without authorization" do
        login_user
        it "should fail if the user is not a super admin" do
          post :create_admin, params: { email: "test@email.com" }
          expect(response).to have_http_status(:unauthorized)
          expect(json_body[:message]).to eq("You are not authorized to perform this action.")
        end
      end

      it "should fail if the email is invalid" do
        post :create_admin, params: { email: "testemail.com" }
        expect(json_body[:message]).to eq("Validation failed: Email is invalid")
      end

      it "should fail if the email is empty" do
        post :create_admin, params: { email: "" }
        expect(json_body[:message]).to eq("Email must be provided")
      end

      it "should succeed" do
        post :create_admin, params: { email: "test@email.com" }
        expect(response).to be_successful
        expect(json_body[:message]).to eq("Email successfuly sent to test@email.com")
      end
    end
  end

  describe "Admin" do
    context "when registering" do
      before :each do
        @user = FactoryBot.create(:user)
      end

      login_admin
      it "should fail if the email is invalid" do
        put :register_admin, params: { email: "teste@mail.com" }
        expect(json_body[:message]).to eq("Admin not found with that email")
        expect(response).to have_http_status(:not_found)
      end

      it "should fail if the user is not an admin" do
        put :register_admin, params: { email: @user.email, admin: {} }
        expect(json_body[:message]).to eq("User not an admin")
      end

      it "should fail if the validation are violated #password" do
        put :register_admin, params: { email: "admin@gmail.com", admin: { password: "js" } }
        expect(json_body[:message].first).to eq("Password is too short (minimum is 6 characters)")
      end

      it "should succeed" do
        put :register_admin, params: {
          "email": "admin@gmail.com",
          "admin": {
            "names": "admin bwenge",
            "sex": "M",
                "password": "%26^hj&ujWwe"
              }
        }
        expect(response.headers).to include("Authorization")
        expect(response.headers["Authorization"]).to include("Bearer")
        expect(json_body).to have_key(:names)
      end
    end
  end
end
