require 'rails_helper'

RSpec.describe QrcodeController, :type => :controller do
  
  before do
  	@controller = QrcodeController.new
  end

  describe "Test QrcodeController methods" do

  	it "reset database success" do 
  	  get :index
  	  expect(Deal.count).to eq 0
  	  expect(Player.count).to eq 0
  	end
  end

end
