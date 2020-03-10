class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions
  validates :name, presence: true, uniqueness: true
end
