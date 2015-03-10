class AddNotificationsStatus < ActiveRecord::Migration
  def change
    add_column :notifications, :status, :integer, :default=>1
  end
end
