class AddDiscardedAtToInspectionSets < ActiveRecord::Migration[5.2]
  def change
    add_column :inspection_sets, :discarded_at, :datetime
    add_index :inspection_sets, :discarded_at
  end
end
