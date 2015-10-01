class AddWinnumberType3AndWinnumberType4InDeals < ActiveRecord::Migration
  def change
    add_column :deals, :winnumber_type_3, :string
    add_column :deals, :winnumber_type_4, :string
    rename_column :deals, :winnumber, :winnumber_type_2
  end
end
