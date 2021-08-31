require 'rails_helper'
RSpec.describe Api::V1::SurvivorsController do
  describe "GET #index" do
    before do
      FactoryBot.create(:survivor)
      get :index
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains expected survivors attributes" do
      json_response = JSON.parse response.body 
      expect(json_response[0].keys()).to match_array ["id", "name", "age", "gender", "longitude", "latitude", "infected", "created_at", "updated_at"]
    end
  end
  describe "PUT #update" do
    before do
      FactoryBot.create(:survivor)
      put :update ,params: {"id": 1, "survivor": {latitude: 3.5,longitude: 2.5}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains Updated survivors location" do
      json_response = JSON.parse response.body 
      expect(json_response["longitude"]).to eq "2.5"
      expect(json_response["latitude"]).to eq "3.5"
    end
  end
  describe "POST #create" do
    before do
      post :create ,params: {survivor: FactoryBot.attributes_for(:survivor)}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains id for newly created object" do
      json_response = JSON.parse response.body 
      expect(json_response["id"]).to eq 1
    end
  end
end