class SensorType < ActiveRecord::Base
  has_many :sensors
  has_many :layers
  validates :name, presence: true
end
