class FixColumn < ActiveRecord::Migration
  def change
  	rename_column :players, :Colume, :column
  end
end
