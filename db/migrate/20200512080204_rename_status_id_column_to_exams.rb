class RenameStatusIdColumnToExams < ActiveRecord::Migration[6.0]
  def change
    rename_column(:exams, :status_id, :status)
  end
end
