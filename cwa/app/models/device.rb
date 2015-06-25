class Device < ActiveRecord::Base
  belongs_to :device_profile
  belongs_to :user
  validates :user_id, presence: true
  validates :device_profile_id, presence: true
end
