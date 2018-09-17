class CreateInspectionSets < ActiveRecord::Migration[5.2]
  def change
    create_table :inspection_sets do |t|
      t.string :set_name

      t.timestamps
    end
  end
end
