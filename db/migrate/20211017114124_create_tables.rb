class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.string :name
      t.integer :quantity, null: false
      t.integer :min_guests, null: false
      t.integer :max_guests, null: false
      t.time :available_from, null: false
      t.time :available_to, null: false

      t.timestamps
    end
  end
end
