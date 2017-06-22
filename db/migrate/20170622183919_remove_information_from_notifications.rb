class RemoveInformationFromNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :information, :string
  end
end
