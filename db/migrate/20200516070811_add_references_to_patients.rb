class AddReferencesToPatients < ActiveRecord::Migration[6.0]
  def change
    add_reference :patients, :organization, null: false, foreign_key: true
  end
end
