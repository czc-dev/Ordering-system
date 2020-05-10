class ChangeColumnDefaultOfOrders < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:orders, :canceled, false)
    change_column_default(:orders, :status_id, 0)
  end
end
