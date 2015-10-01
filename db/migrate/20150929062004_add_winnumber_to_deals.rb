class AddWinnumberToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :winnumber, :string
  end
end
