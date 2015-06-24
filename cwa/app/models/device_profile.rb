class DeviceProfile < ActiveRecord::Base
  has_many :devices
  has_many :sensors
end
