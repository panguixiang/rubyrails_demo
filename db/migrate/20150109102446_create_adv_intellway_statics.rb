class CreateAdvIntellwayStatics < ActiveRecord::Migration
  def change
    create_table :adv_intellway_statics do |t|
      t.integer :adver_memberId, :null=>false
      t.integer :adver_intelplan_id, :null=>false
      t.decimal :cost, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.timestamps
    end
  end
end
