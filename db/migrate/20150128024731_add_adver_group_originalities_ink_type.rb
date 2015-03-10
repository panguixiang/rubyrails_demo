class AddAdverGroupOriginalitiesInkType < ActiveRecord::Migration
  def change
    add_column :adver_group_originalities, :link_type, :integer, :default=>0
  end
end
