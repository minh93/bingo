require 'rails_helper'

RSpec.describe QrcodeController, :type => :controller do

  before do
  	@controller = QrcodeController.new
  end

  describe "index" do

  	it "create new game session" do
  	  get :index
  	  expect(session[:game_id]).not_to eq nil
  	end
  end

end
