class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.boolean :canceled
      t.datetime :may_result_at
      t.integer :status_id
      t.belongs_to :patient, foreign_key: true

      t.timestamps
    end
  end
end
