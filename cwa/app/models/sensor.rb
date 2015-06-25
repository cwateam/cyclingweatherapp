class Sensor < ActiveRecord::Base
  belongs_to :device_profile
  belongs_to :sensor_type
  validates :sensor_type_id, presence: true
  validates :device_profile_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
end
