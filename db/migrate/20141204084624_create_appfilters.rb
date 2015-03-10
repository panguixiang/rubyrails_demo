class CreateAppfilters < ActiveRecord::Migration
  def change
    create_table :appfilters do |t|
      t.integer :app_produ_id,:null=>false
      t.integer :filter_type,:null=>false
      t.string :filter_content,:null=>false,:default=>'',:limit=>200
      t.timestamps
    end
  end
end
