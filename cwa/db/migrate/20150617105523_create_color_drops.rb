class CreateColorDrops < ActiveRecord::Migration
  def change
    create_table :color_drops do |t|
      t.integer :value
      t.string :color
      t.integer :layer_id

      t.timestamps null: false
    end
  end
end
