class AddNotExistDealAndTurnToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :not_exist_deal, :string
    add_column :deals, :turn, :integer
  end
end
