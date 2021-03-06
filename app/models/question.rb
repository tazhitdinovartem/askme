class Question < ApplicationRecord
  validates :text, presence: true, length: { maximum: 255 }

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions, dependent: :destroy

  after_commit :get_hashtags, on: %i[create update]
  after_destroy :remove_unrelated_hashtags

  private

  def get_hashtags
    self.hashtags =
      "#{text} #{answer}".
      downcase.
      scan(Hashtag::HASHTAG_REGEXP).
      uniq.
      map { |hashtag| Hashtag.find_or_create_by(name: hashtag) }
  end

  def remove_unrelated_hashtags
    Hashtag.includes(:questions).where(questions: { id: nil }).destroy_all
  end
end
