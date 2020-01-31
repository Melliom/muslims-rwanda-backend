# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConfirmationsController, type: :controller do
  describe "Account Confirmation" do
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context "when confirming with a token" do
      it "should fail if the token is invalid" do
        get :show, params: { confirmation_token: "obviously a wrong token" }
        expect(json_body[:details].first).to eq("Confirmation token is invalid")
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when requesting a new confirmation" do
      it "should fail if the email doesnt exist" do
        post :create, params: { user: { email: "invalid-email@gmail.com" } }
        expect(json_body[:details].first).to eq("Email not found")
        expect(response).to have_http_status(:bad_request)
      end

      it "should fail if the email is already confirmed" do
        @user = FactoryBot.create(:user)
        post :create, params: { user: { email: "hadad@gmail.com" } }
        expect(json_body[:details].first).to eq("Email was already confirmed, please try signing in")
        expect(response).to have_http_status(:bad_request)
      end

      it "should succeed" do
        @user = FactoryBot.build(:user)
        @user.confirmed_at = ""
        @user.save
        post :create, params: { user: { email: "hadad@gmail.com" } }
        expect(json_body[:message]).to eq("Confirmation instruction sent to your email")
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
