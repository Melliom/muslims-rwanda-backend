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
end
