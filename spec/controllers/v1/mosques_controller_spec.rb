# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::MosquesController, type: :controller do
  before :each do
    @mosque = FactoryBot.build(:mosque)
  end

  describe "GET #index" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        get :index
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should succeed with admin access" do
      login_admin
      it "returns http success" do
        @mosque = FactoryBot.create_list(:mosque, 6)
        get :index
        expect(response).to have_http_status(:success)
        expect(json_body.size).to be(6)
      end
    end
  end

  describe "POST #create" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        post :create, params: @mosque.as_json
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should succeed with admin access" do
      login_admin
      it "returns http success" do
        post :create, params: @mosque.as_json
        expect(response).to have_http_status(:success)
        expect(json_body).to have_key(:id)
      end
    end
  end
end
