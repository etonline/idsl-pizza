class AddCurrentOrderInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :current_order_id, :integer
  end
end
