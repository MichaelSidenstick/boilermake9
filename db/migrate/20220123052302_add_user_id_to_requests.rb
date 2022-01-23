class AddUserIdToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :user_id, :integer
    add_index :requests, :user_id
  end
end
