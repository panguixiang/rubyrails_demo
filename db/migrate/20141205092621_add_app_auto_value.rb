class AddAppAutoValue < ActiveRecord::Migration
  def change
    add_column :app_produs, :auto_value, :integer, :default=>0
  end
end
