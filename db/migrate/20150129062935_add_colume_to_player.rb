class AddColumeToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :Colume, :string
  end
end
