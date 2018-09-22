class CreateInspectionDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :inspection_details do |t|
      t.string :abbreviation
      t.string :formal_name

      t.timestamps
    end
  end
end
