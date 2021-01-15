# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::AnnouncementsController, type: :controller do
  before :each do
    @announcement = FactoryBot.build(:announcement)
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
        post :create, params: @announcement.as_json
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should not accept invalid tags" do
      login_admin
      it "returns http success" do
        accepted_tags = YAML.load_file("db/data/announcement_tags.yaml")
        @announcement.tags = ["hello", "there"]
        post :create, params: { announcement: @announcement.as_json }

        expect(response).to have_http_status(:bad_request)
        expect(json_body[:message].first).to eq("Tags should be one of #{accepted_tags}".gsub(/[\/"]/, ""))
      end
    end

    context "should succeed with admin access" do
      login_admin
      it "returns http success" do
        post :create, params: { announcement: @announcement.as_json }

        expect(response).to have_http_status(:success)
        expect(json_body[:data]).to have_key(:id)
        expect(json_body[:message]).to eq("Annoucement created")
      end
    end
  end

  describe "GET #update" do
    xit "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #archive" do
    xit "returns http success" do
      get :archive
      expect(response).to have_http_status(:success)
    end
  end
end
