class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.string :image
      t.string :publisher
      t.string :year
      t.string :genre

      t.timestamps
    end
  end
end
