class CreateJoinTableCombination < ActiveRecord::Migration[5.2]
  def change
    create_join_table :inspection_sets, :inspection_details, table_name: :combinations do |t|
      # t.index [:inspection_set_id, :inspection_detail_id]
      # t.index [:inspection_detail_id, :inspection_set_id]
      t.belongs_to :inspection_detail, index: true
      t.belongs_to :inspection_set,    index: true
    end
  end
end
