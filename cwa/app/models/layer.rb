class Layer < ActiveRecord::Base
  belongs_to :sensor_type
  has_many :color_drops
  validates :sensor_type_id, presence: true
  validates :name, presence: true
end
