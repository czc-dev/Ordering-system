class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    rename_column(:employees, :username, :email)
    rename_column(:employees, :password_digest, :crypted_password)
    add_column(:employees, :salt, :string)

    change_column_null(:employees, :email, false)
    change_column_null(:employees, :created_at, false)
    change_column_null(:employees, :updated_at, false)

    add_index(:employees, :email, unique: true)
  end
end
