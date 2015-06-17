class AddColumnDeviceProfileToDevices < ActiveRecord::Migration
  def up
    add_column :devices, :device_profile_id, :string    
  end
  
  def down
    remove_column :devices, :device_profile_id
  end
end
