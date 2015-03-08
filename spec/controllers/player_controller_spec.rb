require 'rails_helper'

RSpec.describe PlayerController, :type => :controller do

  before do
    @controller = PlayerController.new
    game = Deal.create(deal: [23,16,55,33,12])
    session[:game_id] = game.id
    game.players.create(name: 'kienphan')
    get :index, nil, { player_name: 'kienphan' }
    expect(response).to have_http_status(:success)
  end

  describe "index" do
    it "hogehoge" do
    end
  end

  describe "check_spoke_number" do
    it "check spoke number by Dealer" do
      result1 = @controller.check_spoke_number 23
      result2 = @controller.check_spoke_number 47
      expect(result1).to eq true
      expect(result2).to eq false
    end
  end

  describe "check_number" do
    it "check number when click in bingo card response success" do
      xhr :post, :check_number
      expect(response.code).not_to eq 200
    end
  end

  describe "reach" do
    it "check reach status response success" do
      xhr :post, :reach
      expect(response.code).not_to eq 200
    end
  end

  describe "bingo" do
    it "check bingo status response success" do
      xhr :post, :bingo
      expect(response.code).not_to eq 200
    end
  end

  describe "update_deal_numbers" do
    it "response success" do
      xhr :post, :update_deal_numbers
      expect(response.code).not_to eq 200
    end
  end

  describe "login" do

    it "if having more 100 players" do
      game = Deal.create(deal: [1,2,7,9])
      1.upto(100) do |i|
      	game.players.create(name: "#{i}")
      end
      get :login
      expect(response).to render_template(:login_max_out)
      expect(response).not_to render_template(:login)
  	end

    it "if having less than 100 players" do
      game = Deal.create(deal: [1,2,7,9])
      1.upto(10) do |i|
        game.players.create(name: "#{i}")
      end
      get :login
      expect(response).not_to render_template(:login_max_out)
      expect(response).to render_template(:login)
    end
  end

  after(:all) do
    Player.destroy_all
    Deal.destroy_all
    reset_session
  end

end