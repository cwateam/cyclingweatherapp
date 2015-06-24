class DeviceProfile < ActiveRecord::Base
  has_many :devices
  has_many :sensors
  validates :name, presence: true
  validates :data_transformer, presence: true
  validates :device_type, presence: true
end
