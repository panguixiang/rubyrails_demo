class CreateIntelwallUsers < ActiveRecord::Migration
  def change
    create_table :intelwall_users do |t|
      t.string :user_imei,:null=>false,:limit=>50
      t.integer :intel_id,:null=>false
      t.integer :remain_point,:null=>false,:default=>0
      t.timestamps
    end
    add_index :intelwall_users, :user_imei
    add_index :intelwall_users, :intel_id
  end
end
