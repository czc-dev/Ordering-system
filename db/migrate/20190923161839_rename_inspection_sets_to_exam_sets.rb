class RenameInspectionSetsToExamSets < ActiveRecord::Migration[5.2]
  def change
    rename_table :inspection_sets, :exam_sets
  end
end
