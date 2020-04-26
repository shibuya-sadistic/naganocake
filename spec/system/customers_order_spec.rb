# require 'rails_helper'

# describe 'トップページの遷移テスト' do
#   context '新規登録画面に遷移' do
#     it '遷移できる' do
#       # root_pathに移動
#       visit root_path
#       # 新規登録のリンクをクリック
#       click_link '新規登録'
#       # リンククリック後のページが新規登録画面か？
#       expect(current_path).to eq(new_customer_registration_path)
#     end
#   end
# end

# describe '登録～注文' do
#   describe 'カスタマー新規登録' do
#     # context内のテストを実行する前に行う事
#     context '新規登録画面に遷移' do
#       before do
#         @customer = Gimei.new
#         # new_customer_registration_pathに移動
#         visit new_customer_registration_path
#       end
#       it '新規登録' do
#         # フォームに代入
#         fill_in 'customer[last_name]', with: @customer.last.kanji
#         fill_in 'customer[first_name]', with: @customer.first.kanji
#         fill_in 'customer[last_name_kana]', with: @customer.last.katakana
#         fill_in 'customer[first_name_kana]', with: @customer.first.katakana
#         fill_in 'customer[postcode]', with: sprintf('%.7d', rand(10000000))
#         fill_in 'customer[address]', with: @customer.prefecture.kanji + @customer.city.kanji + @customer.town.kanji
#         fill_in 'customer[tel]', with: "0343219876"
#         fill_in 'customer[email]', with: "example@email.com"
#         fill_in 'customer[password]', with: "password"
#         fill_in 'customer[password_confirmation]', with: "password"
#         # 新規登録ボタンをクリック
#         click_button '新規登録'

#         # ボタンを押した後のページ（current_path）がroot_pathであるか？
#         expect(current_path).to eq(root_path)
#       end
#     end
#     context "トップページから商品詳細画面へ" do
#       let!(:genre) { create(:genre) }
#       let!(:product) { create(:product, genre: genre) }
#       let!(:product2) { create(:product2, genre: genre) }
#       let!(:customer) { create(:customer) }
#       before do
#         visit new_customer_session_path
#         fill_in 'customer[email]', with: customer.email
#         fill_in 'customer[password]', with: customer.password
#         click_button 'ログイン'
#       end
#       it "商品詳細画面～注文" do
#         click_link product.name
#         select "2", from: 'cart_item[piece]'
#         click_button "カートに入れる"
#         click_link "買い物を続ける"
#         click_link product2.name
#         select "3", from: 'cart_item[piece]'
#         # buttonならbutton
#         click_button "カートに入れる"
#         # aの場合link
#         click_link "情報入力に進む"
#         # radiobuttonをidで選択
#         choose "payment_1"
#         choose "address_ご自身の住所"
#         click_button "確認画面へ進む"

#         expect(page).to have_content product.name
#         expect(page).to have_content product2.name
#         # expect(page).to have_content 'ご自身の住所'
#         # expect(page).to have_content 'クレジットカード'

#         click_button "注文を確定する"

#         expect(page).to have_content 'ご注文ありがとうございました。'

#         click_link "マイページ"

#         find_all('a')[7].click

#         find_all('a')[4].click

#         expect(page).to have_content '入金待ち'

#       end
#     end
#   end
# end