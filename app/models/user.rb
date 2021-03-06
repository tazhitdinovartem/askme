require 'openssl'

class User < ApplicationRecord
  extend FriendlyId

  EMAIL_VALIDATION_REGEXP = /.+@.+\..+/i
  USERNAME_VALIDATION_REGEXP = /\A[A-Za-z0-9_]+\z/
  HEADER_COLOR_VALIDATION = /\A[0-9A-F]{6}\z/
  AVATAR_URL_VALIDATION = /(https?:\/\/.*\.(?:png|jpg|webp|gif))/
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  validates :username, presence: true, uniqueness: true, format: { with: USERNAME_VALIDATION_REGEXP }, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATION_REGEXP }
  validates :password, confirmation: true, presence: true, on: :create
  validates :header_color, format: { with: HEADER_COLOR_VALIDATION }
  validates :avatar_url, format: { with: AVATAR_URL_VALIDATION }, on: :update, allow_blank: true
  
  has_many :questions, dependent: :destroy
  
  before_validation :format_username_to_downcase, :format_email_to_downcase
  before_save :encrypt_password
  
  scope :sorted, -> { order(username: :asc) }

  friendly_id :username, use: [:slugged, :history]

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  def should_generate_new_friendly_id?
    true
  end

  private

  def format_email_to_downcase
    self.email&.downcase!
  end

  def format_username_to_downcase
    self.username&.downcase!
  end
end
