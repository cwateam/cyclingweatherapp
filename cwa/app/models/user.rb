class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :devices
  has_secure_password 
end
