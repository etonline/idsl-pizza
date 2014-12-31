class AddCategoryIntoForeignKeyInProducts < ActiveRecord::Migration
  def change
    add_foreign_key :products, :categories
  end
end
