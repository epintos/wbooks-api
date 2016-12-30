class AddHistoryCounterForUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rents_counter, :integer, default: 0, null: false
    add_column :users, :comments_counter, :integer, default: 0, null: false
  end
end
