class AddUserNameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_name, :string
    add_index :users, :user_name, unique: true
  end
end
