class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.integer :age
      t.datetime :birth
      t.integer :gender_id
      t.string :name

      t.timestamps
    end
  end
end
