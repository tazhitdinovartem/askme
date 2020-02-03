class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :user, presence: true
  validates :text, presence: true, length: { maximum: 255 }
end
