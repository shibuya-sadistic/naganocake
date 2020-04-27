FactoryBot.define do
  factory :customer do
  	transient do
      customer { Gimei.new }
    end
    last_name { customer.last.kanji }
    first_name { customer.first.kanji }
    last_name_kana { customer.last.katakana }
    first_name_kana { customer.first.katakana }
    postcode { sprintf("%.7d", rand(10000000)) }
    address { customer.prefecture.kanji + customer.city.kanji + customer.town.kanji }
    tel { "0343219876" }
    status { true }
    email { "example@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end