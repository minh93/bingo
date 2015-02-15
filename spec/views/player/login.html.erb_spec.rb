require 'rails_helper'

RSpec.describe "player/login.html.erb", :type => :view do
  before do
  	Player.create(name: 'kienphan')
    Player.create(name: 'tuananh')
  end

  it "test login view failed" do
    player = Player.create(name: 'kienphan')
  	assign(:player, player)
  	render
  	expect(rendered).to include "already been taken"
  end

  it "test login failed when input blank" do
    player = Player.create(name: '')
    assign(:player, player)
    render
    expect(rendered).to include "be blank"
  end
end
