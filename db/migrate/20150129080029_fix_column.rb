class FixColumn < ActiveRecord::Migration
  def change
  	rename_column :players, :colums, :column
  end
end
