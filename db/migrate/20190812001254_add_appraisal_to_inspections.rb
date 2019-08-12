class AddAppraisalToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :appraisal, :string
  end
end
