class FixForeignKeysInDevices < ActiveRecord::Migration
  def change
    remove_column :devices, :user_id, :string
    add_column :devices, :user_id, :integer
    remove_column :devices, :device_profile_id, :string
    add_column :devices, :device_profile_id, :integer
  end
end
