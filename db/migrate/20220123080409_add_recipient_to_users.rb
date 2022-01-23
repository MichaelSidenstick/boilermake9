class AddRecipientToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :recipient, :boolean
  end
end
