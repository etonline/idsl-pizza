json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :cellphone, :landphone, :address, :bonus, :gender
  json.url user_url(user, format: :json)
end
