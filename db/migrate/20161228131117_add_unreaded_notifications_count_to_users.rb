class AddUnreadedNotificationsCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :unread_notifications_count, :integer, default: 0, null: false
  end
end
