class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
has_secure_password

  before_save { |user| user.email = user.email.downcase }

  #validates :name, presence: true
  #validates :name,  presence: true, length: { maximum: 50 }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
end