class User < ApplicationRecord
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
  validates_length_of :password, { in: 6..20 }
  has_secure_password
end
