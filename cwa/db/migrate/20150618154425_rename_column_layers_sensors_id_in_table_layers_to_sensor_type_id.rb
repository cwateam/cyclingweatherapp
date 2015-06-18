class RenameColumnLayersSensorsIdInTableLayersToSensorTypeId < ActiveRecord::Migration
  def change
    rename_column :layers, :layers_sensors_id, :sensor_type_id
  end
end
