class AddTurnNumberAndTempwinnerNumberToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :number_of_turn,  :integer
    add_column :deals, :tempwinner_number, :string
  end
end
