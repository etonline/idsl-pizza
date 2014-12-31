json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :description, :image, :category_id, :order_count
  json.url product_url(product, format: :json)
end
