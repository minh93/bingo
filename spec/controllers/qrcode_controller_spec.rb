require 'rails_helper'

RSpec.describe QrcodeController, :type => :controller do
  
  before do
  	@controller = QrcodeController.new
  end

  describe "Test QrcodeController methods" do

  	it "create new game session" do 
  	  get :index
  	  expect(session[:deal_id]).not_to eq nil
  	end
  end

end
