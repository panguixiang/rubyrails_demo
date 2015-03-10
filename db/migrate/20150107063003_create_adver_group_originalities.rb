class CreateAdverGroupOriginalities < ActiveRecord::Migration
  def change
    create_table :adver_group_originalities do |t|
      t.integer :adverId,:null=>false
      t.integer :adver_gro_id,:null=>false
      t.integer :orig_type,:null=>false
      t.string :title
      t.integer :title_size,:null=>false,:default=>0
      t.string :icon
      t.string :icon_size,:null=>false,:default=>''
      t.string :orig_desc
      t.integer :orig_desc_size,:null=>false,:default=>0
      t.string :orig_detail
      t.integer :orig_detail_size,:null=>false,:default=>0
      t.integer :status,:null=>false,:default=>0
      t.integer :inner_screen_type
      t.string :media
      t.string :media_size,:default=>'',:null=>false
      t.string :media_link
      t.timestamps
    end
  end
end
