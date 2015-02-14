require 'rails_helper'

RSpec.describe Deal, :type => :model do
  it "save success" do
  	deal_1 = Deal.create(number: 3)
  	deal_2 = Deal.create(number: 64)
  	deal_3 = Deal.create(number: 75)
  	deal_4 = Deal.create(number: 66)
  	deal_5 = Deal.create(number: 33)
  	expect(Deal.all).to eq [deal_1, deal_2, deal_3, deal_4, deal_5]
  end

  it "have none element when begin" do
  	expect(Deal.count).to eq 0
  end

  it "has one after adding one" do
    Deal.create(number: 67)
    expect(Deal.count).to eq 1
  end

  after(:all) { Deal.destroy_all }
end
