class AddPlayerPointToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :player_point, :integer
  end
end
