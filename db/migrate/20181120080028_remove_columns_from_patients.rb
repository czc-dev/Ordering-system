class RemoveColumnsFromPatients < ActiveRecord::Migration[5.2]
  def change
    remove_column :patients, :age, :integer
  end
end
