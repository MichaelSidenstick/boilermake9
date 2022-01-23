class AddNameToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :name, :string
  end
end
