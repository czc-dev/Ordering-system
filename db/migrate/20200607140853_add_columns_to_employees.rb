class AddColumnsToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :role, :integer, null: false, default: 0
  end
end
