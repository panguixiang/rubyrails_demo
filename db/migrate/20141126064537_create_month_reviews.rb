class CreateMonthReviews < ActiveRecord::Migration
  def change
    create_table :month_reviews do |t|
      t.integer :memberId,:null=>false
      t.integer :status, :null=>false,:default=>1
      t.decimal :total_income, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :tax, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :actual_income, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.timestamps
    end
    add_index :month_reviews, :memberId
    add_index :month_reviews, :status
  end
end
