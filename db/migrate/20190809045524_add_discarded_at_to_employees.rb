class AddDiscardedAtToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :discarded_at, :datetime
    add_index :employees, :discarded_at
  end
end
