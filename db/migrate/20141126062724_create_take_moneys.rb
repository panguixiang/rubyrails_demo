class CreateTakeMoneys < ActiveRecord::Migration
  def change
    create_table :take_moneys do |t|
      t.integer :memberId,:null=>false
      t.integer :status, :null=>false,:default=>1
      t.decimal :take_money, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :success_money, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.string :tn,:null=>false
      t.timestamps
    end
    add_index :take_moneys, :memberId
    add_index :take_moneys, :status
  end
end
