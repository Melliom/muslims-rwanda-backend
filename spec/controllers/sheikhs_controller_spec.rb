# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::SheikhsController, type: :controller do
  before :each do
    @sheikh = FactoryBot.build(:sheikh)
  end

  describe "GET #index" do
    xit "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        post :create, params: @sheikh.as_json
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should succeed with admin access" do
      login_admin
      it "returns http success" do
        post :create, params: @sheikh.as_json
        expect(response).to have_http_status(:success)
        expect(json_body).to have_key(:id)
      end
    end
  end

  describe "GET #show" do
    xit "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        put :update, params: @sheikh.as_json.merge({ "id" => 1 })
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should fail when id is not found" do
      login_admin
      it "returns http not_found" do
        put :update, params: @sheikh.as_json.merge({ "id" => 110 })
        expect(response).to have_http_status(:not_found)
        expect(json_body[:message]).to eq("Couldn't find Sheikh with 'id'=110")
      end
    end

    context "should update successfully" do
      login_admin
      it "returns http ok" do
        @sheikh.save
        put :update, params: @sheikh.as_json.merge({ "id" => @sheikh.id, names: "Hadad Bwenge" })
        expect(response).to have_http_status(:ok)
        expect(json_body[:names]).to eq("Hadad Bwenge")
      end
    end
  end

  describe "GET #destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
