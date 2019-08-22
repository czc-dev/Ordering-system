class AddDiscardedAtToInspectionDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :inspection_details, :discarded_at, :datetime
    add_index :inspection_details, :discarded_at
  end
end
