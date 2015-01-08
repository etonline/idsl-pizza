json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :deliver_time, :total_price, :bonus, :pay_type_id, :contact_phone, :order_time, :deliver_address, :status
  json.url order_url(order, format: :json)
end
