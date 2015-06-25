class FixForeignKeysInSensors < ActiveRecord::Migration
  def change
    remove_column :sensors, :sensor_type_id, :string
    add_column :sensors, :sensor_type_id, :integer
    remove_column :sensors, :device_profile_id, :string
    add_column :sensors, :device_profile_id, :integer
  end
end
