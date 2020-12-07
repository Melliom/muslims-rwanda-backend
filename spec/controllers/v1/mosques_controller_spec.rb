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
        expect(json_body[:data].size).to be(6)
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
        expect(json_body[:data]).to have_key(:id)
      end
    end
  end

  describe "GET #show" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        get :show, params: { "id" => 1 }
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should fail when id is not found" do
      login_admin
      it "returns http not_found" do
        get :show, params: { "id" => 0 }
        expect(response).to have_http_status(:not_found)
        expect(json_body[:message]).to eq("Couldn't find Mosque with 'id'=0")
      end
    end

    context "should get one successfully" do
      login_admin
      it "returns http ok" do
        @mosque.save
        get :show, params: { "id" => @mosque.id }
        expect(response).to have_http_status(:ok)
        expect(json_body[:data][:name]).to eq(@mosque.name)
      end
    end
  end

  describe "PUT #update" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        put :update, params: @mosque.as_json.merge({ "id" => 1 })
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should fail when id is not found" do
      login_admin
      it "returns http not_found" do
        put :update, params: @mosque.as_json.merge({ "id" => 0 })
        expect(response).to have_http_status(:not_found)
        expect(json_body[:message]).to eq("Couldn't find Mosque with 'id'=0")
      end
    end

    context "should update successfully" do
      login_admin
      it "returns http ok" do
        @mosque.save
        put :update, params: @mosque.as_json.merge({ "id" => @mosque.id, name: "Al haajab" })
        expect(response).to have_http_status(:ok)
        expect(json_body[:data][:name]).to eq("Al haajab")
      end
    end
  end
end
