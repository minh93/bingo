require 'rails_helper'

RSpec.describe PlayerController, :type => :controller do

  before do
    @controller = PlayerController.new
    Player.create(name: 'kienphan')
    get :index, nil, { player_name: 'kienphan' }
    expect(response).to have_http_status(:success)
  end

  describe "Test Index view" do 

    it "check card not null" do
      card = @controller.instance_variable_get(:@card)
      expect(card).not_to eq nil
    end

    it "check spoke number by Dealer" do 
      Deal.create(number: 4)
      Deal.create(number: 18)
      Deal.create(number: 47)
      Deal.create(number: 53)
      Deal.create(number: 13)
      result1 = @controller.check_spoke_number 47
      result2 = @controller.check_spoke_number 23
      expect(result1).to eq true
      expect(result2).to eq false
    end

    it "check number when click in bingo card" do
      xhr :post, :check_number
      expect(response.code).not_to eq 200
    end
  end

  describe "Test Login view" do
    it "if having more 100 players" do
      1.upto(100) do |i|
      	Player.create(name: "#{i}")
      end
      get :login
      expect(response).to render_template(:login_max_out)
       expect(response).not_to render_template(:login)
  	end

    it "if having less than 100 players" do
      1.upto(10) do |i|
        Player.create(name: "#{i}")
      end
      get :login
      expect(response).not_to render_template(:login_max_out)
      expect(response).to render_template(:login)
    end
  end

  after(:all) { 
    Player.destroy_all 
    Deal.destroy_all
  }

end
