class RemoveProfileNameFromDeviceProfiles < ActiveRecord::Migration
  def change
    remove_column :device_profiles, :profile_name, :string
  end
end
