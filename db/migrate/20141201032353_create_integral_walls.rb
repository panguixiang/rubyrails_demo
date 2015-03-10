class CreateIntegralWalls < ActiveRecord::Migration
  def change
    create_table :integral_walls do |t|
      t.integer :memberId,:null => false
      t.string :app_name,:null => false, :default => '',:limit => 120
      t.string :platform,:null => false, :default => '',:limit => 30
      t.integer :status,:null=>false,:default=>1
      t.integer :checkstatus,:null=>false,:default=>1
      t.string :app_type,:null => false, :default => '',:limit => 20
      t.string :publisherid,:null => false, :default => '',:limit => 32
      t.string :source,:null => false, :default => '',:limit => 240
      t.string :package_type,:limit => 16
      t.string :version_code,:limit => 30
      t.string :package_name,:limit => 80
      t.integer :adver_type
      t.decimal :active_income, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.string :currency_name,:null => false, :default => '',:limit => 25
      t.integer :exchange_rate,:null=>false,:default=>0
      t.integer :ishow_balance,:null=>false,:default=>1
      t.timestamps
    end
    add_index :integral_walls, :memberId
  end
end
