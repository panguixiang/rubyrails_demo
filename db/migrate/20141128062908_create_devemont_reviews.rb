class CreateDevemontReviews < ActiveRecord::Migration
  def change
    create_table :devemont_reviews do |t|
      t.integer :memberId,:null => false
      t.decimal :month_income, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :month_tax, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.decimal :month_actual, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.integer :status,:null=>false,:default=>1
      t.timestamps
    end
    add_index :devemont_reviews, :memberId
    add_index :devemont_reviews, :created_at
  end
end
