FactoryBot.define do
  factory :product do
  	genre
    name { "ケーキ" }
    introduction { "最高の一品" }
    genre_id { genre.id }
    price { 4000 }
    image_id {  }
    status { true }
  end
end