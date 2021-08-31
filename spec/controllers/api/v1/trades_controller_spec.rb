require 'rails_helper'
RSpec.describe Api::V1::TradesController do
  describe "trade should be successfull when all conditions meet" do
    before do
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        @survivor1 = FactoryBot.create(:survivor)
        @survivor2 = FactoryBot.create(:survivor)
        FactoryBot.create :item, name: "1", points: 5
        FactoryBot.create :item, name: "2", points: 4
        FactoryBot.create :inventory_item, item_id: 1, survivor: @survivor1
        FactoryBot.create :inventory_item, item_id: 2, survivor: @survivor2
        post :create, params: { 
                        "trade": {
                          "buyer_id": 1,
                          "receiver_id": 2,
                          "buyer_items": [{ item_id: 1, quantity: 4 }],
                          "receiver_items": [{ item_id: 2, quantity: 5 }]
                        }
                    }
    end
    it "returns https success" do
      expect(response).to have_http_status :success
    end
    it "JSON body response contains Updated survivors inventories" do
      expect(@survivor1.inventory_items.first.quantity).to eq 2
      expect(@survivor1.inventory_items.second.quantity).to eq 5
      expect(@survivor2.inventory_items.first.quantity).to eq 1
      expect(@survivor2.inventory_items.second.quantity).to eq 4
    end
  end
  describe "trade should not be successfull when survivor is infected" do
    before do
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        @survivor1 = FactoryBot.create(:survivor)
        @survivor1.infected = true
        @survivor1.save
        @survivor2 = FactoryBot.create(:survivor)
        FactoryBot.create :item, name: "1", points: 5
        FactoryBot.create :item, name: "2", points: 4
        FactoryBot.create :inventory_item, item_id: 1, survivor: @survivor1
        FactoryBot.create :inventory_item, item_id: 2, survivor: @survivor2
        post :create, params: { 
                        "trade": {
                          "buyer_id": 1,
                          "receiver_id": 2,
                          "buyer_items": [{ item_id: 1, quantity: 4 }],
                          "receiver_items": [{ item_id: 2, quantity: 5 }]
                        }
                    }
    end
    it " should throw an error" do
      json_response = JSON.parse response.body 
      expect(json_response["error"]).to eq true
    end
  end
end