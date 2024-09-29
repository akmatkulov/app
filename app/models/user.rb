class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  USER_NAME_REGEX = /\A[a-zA-Z0-9_-]+\z/i
  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :user_name, with: USER_NAME_REGEX
  validates_length_of :email, maximum: 255
  validates_length_of :user_name, { in: 6..16 }
  validates_length_of :name, maximum: 50
  validates_presence_of :name, :user_name, :email
  validates_uniqueness_of :email, :user_name
end
