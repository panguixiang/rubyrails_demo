class AddAppProdsCheckStatus < ActiveRecord::Migration
  def change
    add_column :app_produs, :checkstatus, :integer, :default=>0
  end
end
