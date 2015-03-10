class CreateDeveloperTeams < ActiveRecord::Migration
  def change
    create_table :developer_teams do |t|
      t.integer :memberId,:null => false
      t.string :cardtype,:null => false, :default => 'ID',:limit => 10
      t.string :cardname,:null => false, :default => '',:limit => 50
      t.string :cardnum,:null => false, :default => '', :limit =>30
      t.integer :status,:null => false
      t.integer :isleader,:null => false, :default => 2
      t.integer :rate,:null => false, :default => 0
      t.string :bankaddr,:null => false, :default => '',:limit => 100
      t.string :banknum, :null => false, :default => '',:limit => 40
      t.string :sideurl, :null => false, :default => '',:limit => 100
      t.string :outsideurl, :null => false, :default => '',:limit => 100
      t.timestamps
    end
    add_index :developer_teams, :memberId
  end
end
