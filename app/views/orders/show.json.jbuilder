json.(@order, :id, :deliver_time, :total_price, :pay_type_id, :contact_phone, :deliver_address, :status, :created_at, :bonus, :order_time, :updated_at)
json.order_details(@order_details) do |order_detail|
  json.(order_detail, :id, :order_id, :product_id,)
  json.product_name order_detail.product.name
  json.product_price order_detail.product.price
  json.(order_detail, :quantity, :created_at, :updated_at)
end