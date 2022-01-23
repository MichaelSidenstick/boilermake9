class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|

      t.timestamps
    end
  end
end
