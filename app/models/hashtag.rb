class Hashtag < ApplicationRecord
  extend FriendlyId
  
  HASHTAG_REGEXP = /#[[:word:]-]+/

  validates :name, presence: true, uniqueness: true

  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions
  
  scope :sorted, -> { order(name: :asc) }

  friendly_id :name, use: :slugged

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end
end
