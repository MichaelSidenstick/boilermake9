class AddProductListToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :product_list, :integer, array:true
  end
end
