class RenameColumnsToCombinations < ActiveRecord::Migration[5.2]
  def change
    rename_column :combinations, :inspection_detail_id, :exam_item_id
    rename_column :combinations, :inspection_set_id,    :exam_set_id
  end
end
