class CreateAdvertisings < ActiveRecord::Migration
  def change
    create_table :advertisings do |t|
      t.integer :app_produ_id,:null=>false
      t.string :adver_name,:null=>false,:default=>'',:limit=>30
      t.integer :adver_type,:null=>false
      t.integer :status,:null=>false
      t.string :innlinepid,:null=>false,:default=>'',:limit=>50
      t.string :iscreen,:limit=>18
      t.string :isvideo,:limit=>18
      t.string :ismute,:limit=>18
      t.string :icon,:limit=>18
      t.string :title,:limit=>18
      t.string :content,:limit=>18
      t.string :descrip,:limit=>18
      t.string :media,:limit=>18
      t.timestamps
    end

    add_index :advertisings, :app_produ_id
    add_index :advertisings, :adver_name
    add_index :advertisings, :adver_type
    add_index :advertisings, :status
  end
end
