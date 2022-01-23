class AddProductTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :productToken, :string
  end
end
