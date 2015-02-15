require 'rails_helper'

RSpec.describe DealController, :type => :controller do

  before do
    @controller = DealController.new
  end

  describe "Test DealController's methods" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end


    it "ajax update_event reponse success" do
      xhr :post, :update_event
      expect(response.code).not_to eq 200
    end

    it "check number existed in DB" do
      Deal.create(number: 3);
      Deal.create(number: 13);
      Deal.create(number: 35);
      Deal.create(number: 45);
      Deal.create(number: 39);
      test1 = @controller.check_random_number_existed(35)
      test2 = @controller.check_random_number_existed(30)
      expect(test1).to eq true
      expect(test2).to eq false
    end

    it "create new deal number success" do
      Deal.create(number: 3);
      Deal.create(number: 13);
      Deal.create(number: 35);
      Deal.create(number: 45);
      Deal.create(number: 39);
      count_before = Deal.count
      xhr :post, :add
      count_after = Deal.count
      expect(response.code).not_to eq 200
      expect(count_after).to eq count_before + 1
    end
  end

  after(:all) { Deal.destroy_all }

end
