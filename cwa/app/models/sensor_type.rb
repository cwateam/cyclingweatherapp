class SensorType < ActiveRecord::Base
  has_many :sensors
  has_many :layers
end
