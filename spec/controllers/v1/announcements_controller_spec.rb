# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::AnnouncementsController, type: :controller do
  before :each do
    @announcement = FactoryBot.build(:announcement)
  end

  describe "GET #index" do
    context "should fail without authorization" do
      it "returns http unauthorized for not logged in users" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "should succeed with admin access" do
      login_user
      it "returns http success" do
        @announcements = FactoryBot.create_list(:announcement, 6)
        get :index
        expect(response).to have_http_status(:success)
        expect(json_body[:data].size).to be(6)
      end
    end

    context "should paginate the response" do
      login_user
      it "returns http success" do
        @announcements = FactoryBot.create_list(:announcement, 30)
        get :index
        expect(response).to have_http_status(:success)
        expect(json_body[:data].size).to be(20)
      end
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
      it "returns a bad request " do
        accepted_tags = YAML.load_file("db/data/announcement_tags.yaml")
        @announcement.tags = ["hello", "there"]
        post :create, params: { announcement: @announcement.as_json }

        expect(response).to have_http_status(:bad_request)
        expect(json_body[:message].first).to eq("Tags should be an array of #{accepted_tags}".gsub(/[\/"]/, ""))
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

  describe "PUT #update" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        put :update, params: { "id" => 1 }
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end
    context "should fail when id is not found" do
      login_admin
      it "returns http not_found" do
        put :update, params: @announcement.as_json.merge({ "id" => 0 })
        expect(response).to have_http_status(:not_found)
        expect(json_body[:message]).to eq("Couldn't find Announcement with 'id'=0")
      end
    end

    context "should update successfully" do
      login_admin
      it "returns http ok" do
        @announcement.save
        put :update, params: { id: @announcement.id, announcement: {  title: "Lock down effective" }}
        expect(response).to have_http_status(:ok)
        expect(json_body[:data][:title]).to eq("Lock down effective")
      end
    end
  end


  describe "GET #show" do

    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        post :show, params: { "id" => 1 }
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should fail when id is not found" do
      login_admin
      it do
        get :show, params: { "id": 0 }
        expect(json_body[:message]).to eq("Couldn't find Announcement with 'id'=0")
      end
      
    end

    context "should get one successfully" do
      login_admin
      it  do
        @announcement.save
        get :show, params: { "id": @announcement.id }
        expect(response).to have_http_status(:success)
        expect(json_body[:data][:id]).to eq(@announcement.id)
      end
      
    end
    
  end

  describe "DELETE #archive" do
    context "should fail without authorization" do
      login_user
      it "returns http unauthorized" do
        delete :destroy, params: { "id" => 1 }
        expect(response).to have_http_status(:unauthorized)
        expect(json_body[:message]).to eq("You are not authorized to perform this action.")
      end
    end

    context "should fail when id is not found" do
      login_admin
      it "returns http not_found" do
        delete :destroy, params: { "id" => 0 }
        expect(response).to have_http_status(:not_found)
        expect(json_body[:message]).to eq("Couldn't find Announcement with 'id'=0")
      end
    end

    context "should archive successfully" do
      login_admin
      it "returns http ok" do
        @announcement.save
        delete :destroy, params: { id: @announcement.id }
        expect(response).to have_http_status(:ok)
        expect(json_body[:message]).to eq("Announcement #{@announcement.title.downcase} deleted successfully")
      end
    end
  end

  describe "Search announcement" do
    context "should succeed" do
      login_user
      it "returns http success" do
        @announcement = FactoryBot.create_list(:announcement, 6)
        @random_announcement = FactoryBot.build(:announcement)
        @random_announcement.title = "some random title"
        @random_announcement.save
        get :index, params: { "search" => "random" }
        expect(response).to have_http_status(:success)
        expect(json_body[:data].first.fetch(:title)).to eq(@random_announcement.title)
      end
    end
  end

  describe "filter announcement by tags" do
    context "should succeed" do
      login_admin
      it "returns http success" do
        @announcement = FactoryBot.create_list(:announcement, 6)
        @random_announcement = FactoryBot.build(:announcement)
        @random_announcement.tags = ["fund raise", "announcement"]
        @random_announcement.save
        get :index, params: { "tags": ["fund raise"] }
        expect(response).to have_http_status(:success)
        expect(json_body[:data].first.fetch(:tags)).to include("fund raise")
        expect(json_body[:data].first.fetch(:id)).to eq(@random_announcement.id)
      end
    end
  end
end
