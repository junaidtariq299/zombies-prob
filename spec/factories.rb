FactoryBot.define do
  factory :survivor do
    name { "John" }
    age { 25 }
    longitude { 2.64564 }
    latitude { 73.643536 }
    gender { "male" }
  end
  factory :item  do
    name { "name" }
    points { 2 }
  end

  factory :inventory_item do
    item_id { 1 }
    quantity { 6 }
  end
end