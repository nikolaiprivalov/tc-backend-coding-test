class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :table, null: false, foreign_key: true
      t.string :name
      t.string :email, null: false
      t.integer :guests, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
