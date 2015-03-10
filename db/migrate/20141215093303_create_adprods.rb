class CreateAdprods < ActiveRecord::Migration
  def change
    create_table :adprods do |t|
      t.integer :adver_memberId,:null=>false
      t.string :adver_plan_name,:null=>false
      t.integer :adv_type,:null=>false
      t.string :keywords,:null=>false,:default=>''
      t.integer :status,:null=>false
      t.datetime :puton_begin,:null=>false
      t.datetime :puton_end
      t.integer :puton_agenda,:null=>false
      t.string :agenda_monday
      t.string :agenda_tuesday
      t.string :agenda_wednesday
      t.string :agenda_thursday
      t.string :agenda_firday
      t.string :agenda_saturday
      t.string :agenda_sunday
      t.timestamps
    end
    add_index :adprods, :adver_memberId
    add_index :adprods, :status
    add_index :adprods, :adv_type
    add_index :adprods, :keywords
  end
end
