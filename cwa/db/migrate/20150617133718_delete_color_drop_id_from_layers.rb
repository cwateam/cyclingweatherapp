class DeleteColorDropIdFromLayers < ActiveRecord::Migration
  def change
    remove_column :layers, :color_drop_id
  end
end
