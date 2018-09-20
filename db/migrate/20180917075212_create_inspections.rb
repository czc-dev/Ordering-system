class CreateInspections < ActiveRecord::Migration[5.2]
  def change
    create_table :inspections do |t|
      t.boolean :canceled
      t.integer :status_id
      t.boolean :urgent
      t.belongs_to :inspection_detail, foreign_key: true
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
