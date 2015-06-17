class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.string :name
      t.string :address
      t.string :device_profile_id
      t.string :sensor_type_id

      t.timestamps null: false
    end
  end
end
