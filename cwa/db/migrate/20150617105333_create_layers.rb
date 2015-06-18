class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
      t.string :name
      t.integer :color_drop_id
      t.integer :layers_sensors_id

      t.timestamps null: false
    end
  end
end
