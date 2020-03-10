class Question < ApplicationRecord
  
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions, dependent: :destroy

  validates :user, presence: true
  validates :text, presence: true, length: { maximum: 255 }

  after_create :get_hashtags
  after_update :get_hashtags
  after_destroy :remove_unrelated_hashtags

  def get_hashtags
    hashtags.clear
    
    "#{text} #{answer}"
    .downcase
    .scan(Hashtag::HASHTAG_REGEXP)
    .uniq
    .each { |hashtag| hashtags << Hashtag.find_or_create_by(name: hashtag) }
  end

  def remove_unrelated_hashtags
    Hashtag.includes(:questions).where(questions: { id: nil }).destroy_all
  end
end
