class CreateStatisTallies < ActiveRecord::Migration
  def change
    create_table :statis_tallies do |t|
      t.integer :tallie_type
      t.datetime :tallie_date
      t.timestamps
    end
    add_index :statis_tallies, :tallie_type
  end
end
