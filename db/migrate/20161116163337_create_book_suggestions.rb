class CreateBookSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :book_suggestions do |t|
      t.references :user, foreign_key: true
      t.string :editorial
      t.float :price
      t.string :author
      t.string :title
      t.string :link
      t.string :publisher
      t.integer :year
      t.belongs_to :user
    end
  end
end
