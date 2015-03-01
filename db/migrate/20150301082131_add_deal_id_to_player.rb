class AddDealIdToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :deal_id, :integer
  end
end
