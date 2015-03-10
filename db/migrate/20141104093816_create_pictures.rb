class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :pic_type, :null=>false
      t.string :pic_url, :null=>false,:limit=>255
      t.text :message,:null=>false
      t.integer :seque, :null=>false
      t.string :link_url,:null=>false,:default=>'',:limit=>255
      t.timestamps
    end
  end
end
