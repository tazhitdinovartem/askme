class AddIndexToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_index :questions, :author_id
  end
end
