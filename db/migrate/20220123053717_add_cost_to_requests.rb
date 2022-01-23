class AddCostToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :cost, :float
  end
end
