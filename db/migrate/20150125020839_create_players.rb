class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :reach_status
      t.boolean :bingo_status

      t.timestamps
    end

  end
end
