class Device < ActiveRecord::Base
  belongs_to :device_profile
  belongs_to :user
end
