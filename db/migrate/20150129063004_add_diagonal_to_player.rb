class AddDiagonalToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :Diagonal, :string
  end
end
