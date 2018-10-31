class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :who
      t.string :done

      t.timestamps
    end
  end
end
