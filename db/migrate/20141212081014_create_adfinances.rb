class CreateAdfinances < ActiveRecord::Migration
  def change
    create_table :adfinances do |t|
      t.decimal :consumday, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :memberId,:null=>false
      t.decimal :now_balance, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.timestamps
    end
    add_index :adfinances, :memberId
  end
end
