class CreateDevemonthRewards < ActiveRecord::Migration
  def change
    create_table :devemonth_rewards do |t|
      t.integer :memberId,:null => false
      t.decimal :rewincome, :null=>false,:default=>0.00,:precision=>10,:scale=>2
      t.string :rewdescrip,:limit=>100
      t.string :rn,:limit=>40
      t.timestamps
    end
    add_index :devemonth_rewards, :memberId
    add_index :devemonth_rewards, :created_at
  end
end
