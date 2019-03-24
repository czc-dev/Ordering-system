class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :content
      t.integer :order_id
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
