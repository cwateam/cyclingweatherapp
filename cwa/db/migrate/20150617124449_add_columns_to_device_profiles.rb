class AddColumnsToDeviceProfiles < ActiveRecord::Migration
  def up
    add_column :device_profiles, :name, :string
    add_column :device_profiles, :profile_name, :string
    add_column :device_profiles, :device_type, :string
    add_column :device_profiles, :hw_version, :string
    add_column :device_profiles, :sw_version, :string
    add_column :device_profiles, :info, :string
  end
  
  def down
    remove_column :device_profiles, :info
    remove_column :device_profiles, :sw_version
    remove_column :device_profiles, :hw_version
    remove_column :device_profiles, :device_type
    remove_column :device_profiles, :profile_name
    remove_column :device_profiles, :name
  end
end
