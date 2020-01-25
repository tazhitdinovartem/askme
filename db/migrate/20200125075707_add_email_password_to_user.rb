class AddEmailPasswordToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
  end
end
