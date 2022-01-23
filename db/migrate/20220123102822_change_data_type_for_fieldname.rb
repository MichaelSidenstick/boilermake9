class ChangeDataTypeForFieldname < ActiveRecord::Migration[6.0]
  def change

    change_table :requests do |t|
      t.change :product_list, :string, array: true, default: []
    end

  end
end
