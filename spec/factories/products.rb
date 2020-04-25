FactoryBot.define do
  factory :product, class: Product do
    name { "シフォンケーキ" }
    introduction { "最高の一品" }
    genre_id { genre.id }
    price { 4000 }
    image_id { "" }
    status { true }
  end
  factory :product2, class: Product do
    name { "ガトーショコラ" }
    introduction { "最高の一品" }
    genre_id { genre.id }
    price { 4000 }
    image_id { "" }
    status { true }
  end
end