class User < ApplicationRecord
  attr_accessor :remember_token

  normalizes :email, with: ->(email) { email.downcase }
  normalizes :user_name, with: ->(user_name) { user_name.downcase }
  EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  USER_NAME_REGEX = /\A[a-zA-Z0-9_-]+\z/i
  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :user_name, with: USER_NAME_REGEX
  validates_length_of :email, maximum: 255
  validates_length_of :user_name, { in: 6..16 }
  validates_length_of :name, maximum: 50
  validates_presence_of :name, :user_name, :email
  validates_uniqueness_of :email, :user_name, case_sensitive: true
  validates :password, length: { in: 6..20 }, allow_blank: true
  has_secure_password

  # Return digest for string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
            BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Return random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember user in database
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true, if token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget user in database
  def forget
    update_attribute(:remember_digest, nil)
  end
end
