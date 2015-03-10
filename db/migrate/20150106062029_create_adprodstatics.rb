class CreateAdprodstatics < ActiveRecord::Migration
  def change
    create_table :adprodstatics do |t|
      t.integer :adver_memberId,:null=>false
      t.integer :adverId,:null=>false
      t.integer :adver_gro_id,:null=>false
      t.integer :adver_orig_id,:null=>false
      t.string :bill_type,:null=>false
      t.decimal :cost,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :displaynum,:null=>false,:default=>0
      t.integer :clickNum,:null=>false,:default=>0
      t.integer :install_count,:null=>false,:default=>0
      t.integer :download_count,:null=>false,:default=>0
      t.timestamps
    end
    add_index :adprodstatics, :adver_memberId
    add_index :adprodstatics, :adverId
  end
end
