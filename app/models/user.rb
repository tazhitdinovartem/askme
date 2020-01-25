class User < ApplicationRecord

  has_many :questions

  validates :email, :username, presence: true, uniqueness: true
end
