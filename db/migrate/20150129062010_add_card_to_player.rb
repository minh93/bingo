class AddCardToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :card, :string
  end
end
