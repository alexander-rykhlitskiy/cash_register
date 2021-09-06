FactoryBot.define do
  factory :product do
    name { 'Product name' }
    code { 'PR1' }
    price { 10.0 }
    count_for_discount { 3 }
    discount_percent { 33.33 }
  end
end
