class RenameSetNameColumnToExamSets < ActiveRecord::Migration[6.0]
  def change
    rename_column :exam_sets, :set_name, :name
  end
end
