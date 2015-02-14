require 'rails_helper'

RSpec.describe DealController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "create new number when Dealing" do
  	deal = Deal.create(number: 5)
  	current_deal_num = response_body
  	expect(response.status).to eq 200
  	expect(current_deal_num["number"]).to eq deal.number
  end

  def response_body
    JSON.parse(response.body)
  end

end
