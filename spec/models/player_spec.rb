require 'rails_helper'

RSpec.describe Player, :type => :model do
  it "save success" do
  	player_1 = Player.create(name: 'kienphan')
  	player_2 = Player.create(name: 'tuananh')
  	expect(Player.all).to eq [player_1, player_2]
  end

  it "have none element when begin" do
  	expect(Player.count).to eq 0
  end

  it "has one after adding one" do
    Player.create(name: 'kienphan')
    expect(Player.count).to eq 1
  end

  it "if player's name is blank" do
  	player = Player.new(name: '')
  	player.valid?
  	expect(player.errors[:name]).to include "can't be blank"
  end

  it "if input name is existed in db" do
  	Player.create(name: 'kien')
  	player = Player.create(name: 'kien')
  	player.valid?
  	expect(player.errors[:name]).to include "has already been taken"
  end

  it "find user by name" do
  	player_1 = Player.create(name: 'kienphan')
  	player_2 = Player.create(name: 'tuananh')
  	player_3 = Player.create(name: 'kien')
  	player_4 = Player.create(name: 'tuan_anh')
  	player_5 = Player.create(name: 'kien_phan')
  	player_6 = Player.create(name: 'tuan-anh')
	result = Player.find_by name: 'kien'
  	expect(result.name).to eq 'kien'
  end

  after(:all) { Player.destroy_all }
end
