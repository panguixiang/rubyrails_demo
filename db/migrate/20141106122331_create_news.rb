class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title,:null=>false,:default=>'',:limit=>30
      t.string :introduction,:null=>false,:default=>'',:limit=>500
      t.string :comefrom,:limit=>40
      t.text :context,:null=>false
      t.string :url,:null=>false,:default=>'',:limit=>255
      t.timestamps
    end
  end
end
