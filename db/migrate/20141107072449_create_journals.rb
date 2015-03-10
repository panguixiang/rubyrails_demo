class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :name,:null=>false,:default=>'',:limit=>20
      t.string :url,:null=>false,:limit=>255
      t.text :context,:null=>false
      t.timestamps
    end
  end
end
