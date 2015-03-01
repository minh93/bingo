class AddIndexes < ActiveRecord::Migration
  def change
	add_index(:players, [ :deal_id , :name ] , unique: true)
  end
end
