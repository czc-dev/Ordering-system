class ChangeColumnDefaultOfExams < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:exams, :urgent, false)
    change_column_default(:exams, :canceled, false)
    change_column_default(:exams, :submitted, false)
    change_column_default(:exams, :status_id, 0)
    change_column_default(:exams, :sample, '')
    change_column_default(:exams, :result, '')
    change_column_default(:exams, :appraisal, '')
  end
end
