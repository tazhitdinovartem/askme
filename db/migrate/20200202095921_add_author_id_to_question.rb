class AddAuthorIdToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :author_id, :integer
  end
end
