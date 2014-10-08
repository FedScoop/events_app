class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /[^@]+@fedscoop.com/
  # validates :password, presence: true
  before_validation { |user|
    user.first_name = user.first_name.strip
    user.last_name = user.last_name.strip
    user.email = user.email.strip
    user.email = user.email.downcase
  }
end
