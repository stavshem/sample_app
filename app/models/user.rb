class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
has_secure_password

  before_save { |user| user.email = user.email.downcase }

  validates :name, presence: true

end
