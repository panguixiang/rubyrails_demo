class CreateAppProdus < ActiveRecord::Migration
  def change
    create_table :app_produs do |t|
      t.integer :memberId,:null=>false,:default=>''
      t.string :app_name,:null=>false,:default=>'',:limit=>30
      t.string :platform,:null=>false,:default=>'',:limit=>30
      t.integer :status,:null=>false,:default=>''
      t.string :app_type,:null=>false,:default=>'',:limit=>30
      t.string :publisherid,:null=>false,:default=>'',:limit=>50
      t.string :url,:null=>false,:default=>'',:limit=>30
      t.string :keyword,:null=>false,:default=>'',:limit=>30
      t.integer :isposition,:null=>false,:default=>''
      t.string :app_content,:default=>''
      t.string :auto_reflush,:default=>''
      t.string :package_name,:default=>'',:limit=>120
      t.string :version_code,:default=>'',:limit=>30
      t.timestamps
    end
    add_index :app_produs, :memberId
    add_index :app_produs, :status
  end
end
