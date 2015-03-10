class CreateAppStatics < ActiveRecord::Migration
  def change
    create_table :app_statics do |t|
      t.integer :memberId,:null=>false
      t.integer :app_id,:null=>false
      t.string :bill_type, :null=>false,:limit=>10
      t.integer :adverting_id, :null=>false
      t.integer :adverting_type, :null=>false
      t.decimal :incoming, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :request_count, :null=>false
      t.integer :fill_count, :null=>false
      t.integer :display_count, :null=>false
      t.integer :click_count, :null=>false
      t.timestamps
    end

    add_index :app_statics, :memberId
    add_index :app_statics, :app_id
    add_index :app_statics, :bill_type
    add_index :app_statics, :adverting_id
    add_index :app_statics, :adverting_type
    add_index :app_statics, :created_at
  end
end
