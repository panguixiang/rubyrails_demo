class CreateAdverPlanGroups < ActiveRecord::Migration
  def change
    create_table :adver_plan_groups do |t|
      t.integer :adverId,:null=>false
      t.decimal :budget_day,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :buget,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.string :group_name,:null=>false
      t.string :bill_type,:null=>false
      t.integer :status,:null=>false,:defautl=>0
      t.decimal :price,:null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :sex,:null=>false,:defautl=>0
      t.integer :region_type,:null=>false,:defautl=>1
      t.string :region_area
      t.timestamps
    end

    add_index :adver_plan_groups, :adverId
    add_index :adver_plan_groups, :sex
    add_index :adver_plan_groups, :region_type
  end
end
