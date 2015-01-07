json.array!(@order_details) do |order_detail|
  json.extract! order_detail, :id, :order_id, :product_id, :quantity
  json.url order_order_detail_url(@order, order_detail, format: :json)
end
