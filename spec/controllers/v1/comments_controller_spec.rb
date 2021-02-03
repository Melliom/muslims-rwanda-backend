# frozen_string_literal: true
require "rails_helper"

RSpec.describe V1::CommentsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #archive" do
    it "returns http success" do
      get :archive
      expect(response).to have_http_status(:success)
    end
  end

end
