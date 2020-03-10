class Question < ApplicationRecord
  
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions, dependent: :destroy

  validates :user, presence: true
  validates :text, presence: true, length: { maximum: 255 }

  after_create :get_hashtags
  after_update :get_hashtags

  def get_hashtags
    hashtags.clear
    
    "#{text} #{answer}"
    .downcase
    .scan(Hashtag::HASHTAG_REGEXP)
    .uniq
    .map { |hashtag| Hashtag.find_or_create_by(name: hashtag) }
  end
end
