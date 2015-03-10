class CreateHelpCenters < ActiveRecord::Migration
  def change
    create_table :help_centers do |t|
      t.integer :cate1,:null=>false
      t.string :title,:limit=>70
      t.text :context
      t.integer :sequc
      t.timestamps
    end
  end
end
