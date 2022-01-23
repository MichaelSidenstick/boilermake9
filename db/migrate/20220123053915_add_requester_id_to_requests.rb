class AddRequesterIdToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :requester_id, :integer
  end
end
