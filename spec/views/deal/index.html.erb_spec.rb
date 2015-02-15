require 'rails_helper'

RSpec.describe "deal/index.html.erb", :type => :view do
  before do
  	Deal.create(number: 5)
  	Deal.create(number: 8)
  	Deal.create(number: 56)
  	Deal.create(number: 32)
  	Deal.create(number: 17)
  	Deal.create(number: 35)
  end

  it "test index view" do
  	assign(:current_number, Deal.last)
  	assign(:dealed_numbers, Deal.all)
  	render
  	expect(rendered).not_to eq nil
  	expect(rendered).not_to eq nil
  end
end
