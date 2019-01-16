class AddColumnsToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :sample, :string
    add_column :inspections, :result, :string
  end
end
