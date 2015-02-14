class AddCardStatusToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :card_status, :string
  end
end
