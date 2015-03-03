require 'rails_helper'

RSpec.describe DealController, :type => :controller do

  before do
    @controller = DealController.new
  end
  ###テストの書き方としてかきのようにまとめるよりメソッド毎に切り分けたほうが他の人が見たときにわかりやすいよ
  ###あと成功の例テストだけでなくて、失敗のテストもおこなったほうが良いよ
  describe "index"
    it "hogehoge" do
    end
  end

  describe "update_event" do
  end

  describe "add" do
  end

  describe "Test DealController's methods" do

    it "ajax update_event reponse success" do
      xhr :post, :update_event
      expect(response.code).not_to eq 200
    end

    it "check number existed in DB" do
      game = Deal.create(deal: [13, 35, 45, 39, 66]);
      deal_list = Deal.find(game.id).deal
      test1 = @controller.check_random_number_existed(deal_list, 35)
      test2 = @controller.check_random_number_existed(deal_list, 30)
      expect(test1).to eq true
      expect(test2).to eq false
    end

    it "create new deal number success" do
      game = Deal.create(deal: [13, 35, 45, 39, 66]);
      session[:deal_id] = game.id
      deal_list = Deal.find(session[:deal_id]).deal
      count_before = deal_list.length
      xhr :post, :add
      deal_list = Deal.find(session[:deal_id]).deal
      count_after = deal_list.length
      expect(response.code).not_to eq 200
      expect(count_after).to eq count_before + 1
    end

  end

  after(:all) {
    Deal.destroy_all
    reset_session
  }

end
