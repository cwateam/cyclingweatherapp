class RemoveColumnDatatransformerFromDevices < ActiveRecord::Migration
  def up
    remove_column :devices, :datatransformer
  end

  def down
    add_column :devices, :datatransformer, :string    
  end
end
