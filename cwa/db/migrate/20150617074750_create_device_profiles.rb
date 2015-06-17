class CreateDeviceProfiles < ActiveRecord::Migration
  def change
    create_table :device_profiles do |t|
      t.string :data_transformer

      t.timestamps null: false
    end
  end
end
