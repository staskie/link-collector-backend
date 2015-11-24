class AddUuidAndTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string, unique: true
    add_column :users, :token, :string
  end
end
