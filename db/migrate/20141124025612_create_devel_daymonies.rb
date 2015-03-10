class CreateDevelDaymonies < ActiveRecord::Migration
  def change
    create_table :devel_daymonies do |t|
      t.integer :memberId,:null => false
      t.decimal :cum_revenue, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :unincome, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :confirincome, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :waitcash, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :cancash, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :alreadcash, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :rewardcash, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :automatic, :null => false, :default=>1
      t.timestamps
    end
    add_index :devel_daymonies, :memberId
    add_index :devel_daymonies, :created_at
    add_index :devel_daymonies, :automatic
  end
end
