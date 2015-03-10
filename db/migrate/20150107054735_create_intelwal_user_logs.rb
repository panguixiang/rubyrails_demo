class CreateIntelwalUserLogs < ActiveRecord::Migration
  def change
    create_table :intelwal_user_logs do |t|
      t.string :user_imei,:null=>false,:limit => 50
      t.integer :intel_plan_id,:null=>false
      t.timestamps
    end
    add_index :intelwal_user_logs, :user_imei
    add_index :intelwal_user_logs, :intel_plan_id
  end
end
