class Order < ActiveRecord::Base
  has_many :order_detail, dependent: :destroy
end
