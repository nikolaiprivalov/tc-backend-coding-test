class AddIndexToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :tables, %i[restaurant_id min_guests]
  end
end
