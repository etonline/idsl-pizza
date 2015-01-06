class AddQuantityToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :quantity, :integer
  end
end
