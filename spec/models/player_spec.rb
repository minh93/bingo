require 'rails_helper'

RSpec.describe Player, :type => :model do
  before do
    @deal = Deal.create(deal: Array.new)
  end
  it "save success" do
  	player_1 = @deal.players.create(name: 'tuananh')
    player_2 = @deal.players.create(name: 'kienphan')
  	expect(Player.all).to eq [player_1, player_2]
  end

  it "have none element when begin" do
  	expect(Player.count).to eq 0
  end

  it "has one after adding one" do
    @deal.players.create(name: 'kienphan')
    expect(Player.count).to eq 1
  end

  it "if player's name is blank" do
  	player = @deal.players.create(name: '')
  	player.valid?
  	expect(player.errors[:name]).to include "can't be blank"
  end

  it "if input name is existed in db" do
  	@deal.players.create(name: 'kien')
  	player = @deal.players.create(name: 'kien')
  	player.valid?
  	expect(player.errors[:name]).to include "has already been taken"
  end

  it "find user by name" do
  	@deal.players.create(name: 'kienphan')
  	@deal.players.create(name: 'tuananh')
  	@deal.players.create(name: 'kien')
  	@deal.players.create(name: 'tuan_anh')
  	@deal.players.create(name: 'kien_phan')
  	@deal.players.create(name: 'tuan-anh')
	  result = Player.joins(:deal).where( players: { deal_id: @deal.id, name: 'kien' }).first
  	expect(result.name).to eq 'kien'
  end

  after(:all) { 
    Player.destroy_all
    Deal.destroy_all
  }
end
