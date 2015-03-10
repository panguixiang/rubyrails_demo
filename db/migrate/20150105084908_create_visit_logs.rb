class CreateVisitLogs < ActiveRecord::Migration

  def change
    create_table :visit_logs do |t|
      t.integer :memberId,:null => false,:default=>0
      t.integer :adver_memberId,:null=>false,:default=>0
      t.integer :app_id,:null => false,:default=>0
      t.integer :adver_id,:null => false,:default=>0
      t.integer :ad_group_id, :null => false,:default=>0
      t.integer :ad_originality_id,:null => false,:default=>0
      t.integer :adver_position_id, :null => false,:default=>0
      t.integer :adver_position_type,:null => false,:default=>0
      t.string :imei, :null => false, :default=>'',:limit=>40
      t.string :bill_type, :null => false, :default=>'',:limit=>10
      t.decimal :cost, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :devel_cost,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :isfilling,:default=>0
      t.integer :isrequest,:default=>0
      t.integer :isdisplay,:default=>0
      t.integer :isclicked,:default=>0
      t.integer :isdownload,:default=>0
      t.integer :isinstall,:default=>0
      t.timestamps
    end
    add_index :visit_logs, :memberId
    add_index :visit_logs, :adver_memberId
    add_index :visit_logs, :app_id
    add_index :visit_logs, :adver_id
    add_index :visit_logs, :ad_group_id
    add_index :visit_logs, :ad_originality_id
    add_index :visit_logs, :adver_position_id
    add_index :visit_logs, :imei
    add_index :visit_logs, :bill_type
    add_index :visit_logs, :created_at
  end

end
