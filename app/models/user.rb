class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest

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

  # Set token for attribute and digest for db
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Remember user in database
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true, if token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forget user in database
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    # Create token and save to database digest
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
