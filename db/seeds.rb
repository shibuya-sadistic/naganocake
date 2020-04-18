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
    last_name_kana: Gimei.last.hiragana,
    first_name_kana: Gimei.first.hiragana,
    postcode: sprintf("%.7d", rand(10000000)),
    address: Gimei.address.kanji,
    tel: "123456789",
    status: true,
    email: Faker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
  )
end

Genre.create(
	name: "test1",
	status: true)

Genre.create(
	name: "test2",
	status: true)

Genre.create(
	name: "test3",
	status: true)

Genre.create(
	name: "test4",
	status: true)

10.times do

	random = Random.new

	Product.create!(
		name: "test",
		introduction: "test",
		genre_id: random.rand(1..4),
		price: "500",
		image_id: "1",
		status: true
		)
end