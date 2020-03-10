require 'babosa'

class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end
  
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions
  validates :name, presence: true, uniqueness: true
end
