class RenameStatusIdColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column(:orders, :status_id, :status)
  end
end
