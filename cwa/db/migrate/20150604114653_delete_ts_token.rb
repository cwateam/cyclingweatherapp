class DeleteTsToken < ActiveRecord::Migration
  def up
    drop_table :ts_tokens
  end
  
  def down
    create_table :ts_tokens do |t|
      t.string  :token
    end
  end
end
