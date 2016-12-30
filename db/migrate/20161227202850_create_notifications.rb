class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :reason, null: false
      t.belongs_to :action, polymorphic: true, index: true
      t.integer :action_id
      t.string  :action_type, null: false
      t.string :information, array: true, default: '{}'
      t.boolean :read, default: false

      t.timestamps
    end
    add_reference :notifications, :from, references: :users, index: true
    add_reference :notifications, :to, references: :users, index: true

    add_foreign_key :notifications, :users, column: :from_id
    add_foreign_key :notifications, :users, column: :to_id
  end
end
