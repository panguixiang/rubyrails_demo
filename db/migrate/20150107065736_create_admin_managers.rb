class CreateAdminManagers < ActiveRecord::Migration
  def change
    create_table :admin_managers do |t|
      t.string :nickname,:null=>false,:limit=>30
      t.string :email,:null=>false,:limit=>30
      t.text :password,:null=>false,:limit=>30
      t.integer :status,:default=>0
      t.integer :level
      t.timestamps
    end
  end
end
