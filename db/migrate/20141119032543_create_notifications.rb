class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :memberId,:null=>false,:default=>''
      t.string :title,:null=>false,:default=>'',:limit=>30
      t.text :content,:null=>false
      t.timestamps
    end
    add_index :notifications, :memberId
  end
end
