class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :image
      t.integer :category_id
      t.integer :order_count

      t.timestamps null: false
    end
  end
end
