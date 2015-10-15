class AddNotExistDealAndTurnToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :not_exist_deal, :text
    add_column :deals, :turn, :integer
  end
end
