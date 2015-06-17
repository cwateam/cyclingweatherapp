class Sensor < ActiveRecord::Base
  belongs_to :device_profile
  belongs_to :sensor_type
end
