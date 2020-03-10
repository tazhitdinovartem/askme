class CreateHashtagQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtag_questions do |t|
      t.string :name
      t.references :hashtag, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
