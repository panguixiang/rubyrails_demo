class CreateIntelwallPlans < ActiveRecord::Migration
  def change
    create_table :intelwall_plans do |t|
      t.integer :adver_memberId,:null => false
      t.string :adver_types
      t.string :adver_img,:null => false
      t.string :adver_title,:null=>false
      t.string :adver_desc,:null=>false
      t.string :adv_url,:null=>false
      t.integer :pay_forms,:null=>false
      t.decimal :offer,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.float :offer_rate,:null=>false,:default=>0.00
      t.integer :link_type,:null=>false,:default=>0
      t.datetime :puton_begin,:null=>false
      t.datetime :puton_end,:null=>false
      t.integer :puton_agenda,:null=>false,:default=>1
      t.string :agenda_monday
      t.string :agenda_tuesday
      t.string :agenda_wednesday
      t.string :agenda_thursday
      t.string :agenda_firdday
      t.string :agenda_saturday
      t.string :agenda_sundday
      t.timestamps
    end
    add_index :intelwall_plans, :adver_memberId
    add_index :intelwall_plans, :adver_types
  end
end
