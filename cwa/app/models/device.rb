class Device < ActiveRecord::Base
  belongs_to :device_profiles, :users
end
