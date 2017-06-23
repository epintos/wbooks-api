class AddReturnDateToRents < ActiveRecord::Migration[5.0]
  def change
    add_column :rents, :returned_at, :date, default: nil
  end
end
