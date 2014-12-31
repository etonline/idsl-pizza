class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :deliver_time
      t.integer :total_price
      t.integer :bonus
      t.integer :pay_type_id
      t.string :contact_phone
      t.string :deliver_address
      t.integer :status_id

      t.timestamps null: false
    end
  end
end
