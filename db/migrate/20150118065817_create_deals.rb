class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :number

      t.timestamps
    end
  end
end
