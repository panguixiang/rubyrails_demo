class CreateAppvisitMids < ActiveRecord::Migration
  def change
    create_table :appvisit_mids do |t|
      t.integer :memberId,:null=>false
      t.integer :cpc_display
      t.integer :cpc_click
      t.float :cpc_rate
      t.integer :cpm_display
      t.decimal :now_cost,:null=>false,:precision=>10,:scale=>2
      t.timestamps
    end
    add_index :appvisit_mids, :memberId
    add_index :appvisit_mids, :created_at
  end
end
