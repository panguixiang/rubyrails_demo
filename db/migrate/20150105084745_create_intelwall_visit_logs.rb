class CreateIntelwallVisitLogs < ActiveRecord::Migration

  def change
    create_table :intelwall_visit_logs do |t|
      t.integer :memberId,:null => false
      t.integer :adver_memberId,:null => false
      t.integer :adver_intelplan_id,:null => false
      t.integer :intel_id,:null => false
      t.integer :adver_type,:null => false
      t.string :imei, :null => false, :default=>'',:limit=>40
      t.decimal :cost, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :devel_cost,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :is_enter,:default=>0
      t.integer :is_reshow,:default=>0
      t.integer :is_reclick,:default=>0
      t.integer :is_cover,:default=>0
      t.integer :is_play_begin,:default=>0
      t.integer :is_play_finish,:default=>0
      t.integer :is_active,:default=>0
      t.timestamps
    end
    add_index :intelwall_visit_logs, :memberId
    add_index :intelwall_visit_logs, :intel_id
    add_index :intelwall_visit_logs, :adver_memberId
    add_index :intelwall_visit_logs, :adver_intelplan_id
    add_index :intelwall_visit_logs, :adver_type
    add_index :intelwall_visit_logs, :imei
    add_index :intelwall_visit_logs, :created_at
  end


end
