class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.references :table, null: false, foreign_key: true
      t.integer :quantity_available, null: false
      t.date :date, null: false

      t.index [:table_id, :date], unique: true

      t.timestamps
    end
  end
end
