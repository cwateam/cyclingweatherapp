class Layer < ActiveRecord::Base
  belongs_to :sensor_type
  has_many :color_drops 
end
