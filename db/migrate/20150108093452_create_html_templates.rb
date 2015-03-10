class CreateHtmlTemplates < ActiveRecord::Migration
  def change
    create_table :html_templates do |t|
      t.string :temp_name,:null=>false,:default=>'',:limit=>300
      t.text :content,:null=>false
      t.string :temp_url,:null=>false,:default=>'',:limit=>200
      t.timestamps
    end
  end
end
