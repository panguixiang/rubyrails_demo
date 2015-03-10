class CreateRevenceDetails < ActiveRecord::Migration
  def change
    create_table :revence_details do |t|
      t.integer :memberId,:null => false
      t.decimal :cpc, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :cpm, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :intewall, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.timestamps
    end
    add_index :revence_details, :memberId
    add_index :revence_details, :created_at
  end
end
