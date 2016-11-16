class CreateWish < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
