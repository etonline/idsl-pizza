json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :description, :image, :category_id, :order_count
  json.url category_product_url(@category,product, format: :json)
end
