class CreateIntelwallStatics < ActiveRecord::Migration
  def change
    create_table :intelwall_statics do |t|
      t.integer :intel_id,:null => false
      t.integer :memberId,:null => false
      t.integer :adver_type,:null => false
      t.decimal :active_income, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :enter_count,:null => false,:default=>0
      t.integer :relshow_count,:null => false,:default=>0
      t.integer :relclick_count,:null => false,:default=>0
      t.integer :cover_count,:null => false,:default=>0
      t.integer :active_count,:null => false,:default=>0
      t.integer :play_begin,:null => false,:default=>0
      t.integer :play_finish,:null => false,:default=>0
      t.timestamps
    end
    add_index :intelwall_statics, :intel_id
    add_index :intelwall_statics, :memberId
    add_index :intelwall_statics, :adver_type
    add_index :intelwall_statics, :created_at
  end
end
