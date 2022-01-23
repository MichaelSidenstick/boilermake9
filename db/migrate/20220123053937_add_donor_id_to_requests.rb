class AddDonorIdToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :donor_id, :integer
  end
end
