class AddUserToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :user, :refrences
  end
end
