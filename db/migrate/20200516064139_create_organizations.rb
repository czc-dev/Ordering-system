class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :organizations, :discarded_at
  end
end
