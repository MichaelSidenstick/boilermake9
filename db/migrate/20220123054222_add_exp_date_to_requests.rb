class AddExpDateToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :exp_date, :datetime
  end
end
