class RenameInspectionsToExams < ActiveRecord::Migration[5.2]
  def change
    rename_table :inspections, :exams
  end
end
