class AddColumnDatatransformerToDevices < ActiveRecord::Migration
  def up
    add_column :devices, :datatransformer, :string    
  end

  def down
    remove_column :devices, :datatransformer
  end
end
