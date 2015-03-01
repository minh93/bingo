require 'rails_helper'

RSpec.describe Deal, :type => :model do
  it "create success" do
  	deal_1 = Deal.create(deal: [1,2,3])
  	deal_2 = Deal.create(deal: Array.new)
  	expect(Deal.all).to eq [deal_1, deal_2]
  end

  it "have none element when begin" do
  	expect(Deal.count).to eq 0
  end

  it "has one after adding one" do
    Deal.create(deal: Array.new)
    expect(Deal.count).to eq 1
  end
  
end
