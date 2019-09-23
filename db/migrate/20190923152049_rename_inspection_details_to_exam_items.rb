class RenameInspectionDetailsToExamItems < ActiveRecord::Migration[5.2]
  def change
    rename_table :inspection_details, :exam_items
  end
end
