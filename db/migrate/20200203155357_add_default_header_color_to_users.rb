class AddDefaultHeaderColorToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :header_color, :string, :default => "005A55"
  end
end
