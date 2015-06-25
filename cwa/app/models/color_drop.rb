class ColorDrop < ActiveRecord::Base
  belongs_to :layer
  validates :layer_id, presence: true
  validates :value, presence: true
  validates :color, presence: true
end
