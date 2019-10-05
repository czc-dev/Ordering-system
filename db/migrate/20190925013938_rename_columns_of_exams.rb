class RenameColumnsOfExams < ActiveRecord::Migration[5.2]
  def change
    rename_column :exams, :inspection_detail_id, :exam_item_id
  end
end
