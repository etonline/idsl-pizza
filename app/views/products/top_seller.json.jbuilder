json.array!(@top_products) do |product|
  json.extract! product, :id, :name, :price, :description, :image, :category_id, :order_count
  json.url category_product_url(product.category_id,product, format: :json)
end
