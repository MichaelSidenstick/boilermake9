class AddTypeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :userType, :string
  end
end
