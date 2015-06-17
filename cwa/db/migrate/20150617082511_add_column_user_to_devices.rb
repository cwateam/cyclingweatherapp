class AddColumnUserToDevices < ActiveRecord::Migration
  def up
    add_column :devices, :user_id, :string    
  end

  def down
    remove_column :devices, :user_id
  end
end
