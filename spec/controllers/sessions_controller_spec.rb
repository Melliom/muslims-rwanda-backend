# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  tests SessionsController
  include Devise::TestHelpers


  describe "User login" do
    before :all do
      @user = FactoryBot.create(:user)
    end

    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    after :all do
      User.destroy_all
    end

    it "should fail if the credentials are wrong" do
      post :create, params: {
        "user": {
            "email": "test@gmail.com",
            "password": "J*uD$J2l^v6"
        }
    }
      expect(response.body).to eq("Invalid Email or password.")
      expect(response).to have_http_status(:unauthorized)
    end

    it "while having valid credential should succeed " do
      post :create, params: {
        "user": {
            "email": "hadad@gmail.com",
            "password": "J*uD$J2l^v6Q"
        }
    }
      expect(json_body).to have_key(:email)
      expect(json_body[:email]).to eq(@user.email)
      expect(response).to have_http_status(:ok)
    end
  end
end
