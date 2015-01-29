class FixDiagonal < ActiveRecord::Migration
  def change
  	rename_column :players, :Diagonal, :diagonal
  end
end
