FactoryBot.define do
  factory :order do
    customer_id { customer.id }
    status { 0 }
    postcode { 9999999 }
    address { "東京都" }
    destination { "宛先" }
    payment { 1 }
    created_at { Time.now }
  end
end

