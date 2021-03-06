# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin.create!(
#    email: 'shibuya@dwc.com',
#    password: '123456'
# )

50.times do
  # gimei = Gimei.new

  Customer.create!(
    last_name: Gimei.last.kanji,
    first_name: Gimei.first.kanji,
    last_name_kana: Gimei.last.katakana,
    first_name_kana: Gimei.first.katakana,
    postcode: sprintf("%.7d", rand(10000000)),
    address: Gimei.address.kanji,
    tel: "1234567890",
    status: true,
    email: Faker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
  )
end

# Genre.create(
# 	name: "ケーキ",
# 	status: true)

# Genre.create(
# 	name: "プリン",
# 	status: true)

# Genre.create(
# 	name: "焼き菓子",
# 	status: true)

# Genre.create(
# 	name: "キャンディ",
# 	status: true)

10.times do

	random = Random.new

	Product.create!(
		name: "ケーキ",
		introduction: "おいしい",
		genre_id: random.rand(1..4),
		price: "500",
		image_id: "1",
		status: true
		)
end

15.times do

	random = Random.new

	Order.create!(
		customer_id: 2,
		postage: 800,
		destination: "宛先",
		postcode: sprintf("%.7d", rand(10000000)),
		address: "東京都",
		payment: random.rand(0..1),
		status: 0
		)
end

10.times do

	random = Random.new

	OrderItem.create!(
		order_id: random.rand(1..5),
    	product_id: random.rand(1..5),
    	produce_status: 0,
    	price: "500",
    	piece: random.rand(1..3)
    )
end