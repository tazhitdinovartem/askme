class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[A-zА-я0-9_]+/

  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions
  validates :name, presence: true, uniqueness: true
end
