class AddReferencesToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_reference :employees, :organization, null: false, foreign_key: true
  end
end
