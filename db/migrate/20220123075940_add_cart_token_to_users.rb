class AddCartTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cartToken, :string
  end
end
