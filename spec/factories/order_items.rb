FactoryBot.define do
  factory :order_item do
    order_id { order.id }
    product_id { product.id }
    produce_status { 0 }
    piece { 1 }
    price { 300 }
  end
end