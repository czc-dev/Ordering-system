class AddSubmittedToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :submitted, :boolean
  end
end
