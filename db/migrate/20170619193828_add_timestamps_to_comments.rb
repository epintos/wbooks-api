class AddTimestampsToComments < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :comments, null: true
    Comment.update_all(created_at: Time.zone.now, updated_at: Time.zone.now)
  end
end
