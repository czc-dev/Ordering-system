class CreateSamples < ActiveRecord::Migration[5.2]
  def change
    create_table :samples do |t|
      t.text :condition
      t.belongs_to :inspection, foreign_key: true

      t.timestamps
    end
  end
end
