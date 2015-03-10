class CreateDeveloperInfos < ActiveRecord::Migration
  def change
    create_table :developer_infos do |t|
      t.integer :memberId,:null => false
      t.integer :accountype,:null => false
      t.string :company,:null => false, :default => '',:limit => 120
      t.string :contact,:null => false, :default => '', :limit => 50
      t.string :qq,:null => false, :default => '', :limit =>16
      t.string :msn,:null => false, :default => '', :limit => 60
      t.string :wechat, :null => false, :default => '', :limit => 60
      t.string :mobile, :null => false, :default => '', :limit => 16
      t.string :telphone, :null => false, :default => '', :limit => 18
      t.string :address, :null => false, :default => '', :limit => 130
      t.timestamps
    end
    add_index :developer_infos, :memberId,  :unique => true
  end
end
