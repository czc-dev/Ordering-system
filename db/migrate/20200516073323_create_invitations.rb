class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :token
      t.string :email
      t.references :organization, foreign_key: true
      t.datetime :expired_at
      t.datetime :revoked_at
    end

    add_index :invitations, :token, unique: true
    add_index :invitations, :revoked_at
  end
end
