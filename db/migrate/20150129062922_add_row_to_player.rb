class AddRowToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :Row, :string
  end
end
