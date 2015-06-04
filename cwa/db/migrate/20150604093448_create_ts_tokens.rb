class CreateTsTokens < ActiveRecord::Migration
  def change
    create_table :ts_tokens do |t|
      t.string :token

      t.timestamps null: false
    end
  end
end
