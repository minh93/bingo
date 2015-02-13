class FixRow < ActiveRecord::Migration
  def change
  	rename_column :players, :Row, :row
  end
end
