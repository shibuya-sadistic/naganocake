require 'rails_helper'

describe 'トップページの遷移テスト' do
  context '新規登録画面に遷移' do
    it '遷移できる' do
      # root_pathに移動
      visit root_path
      # 新規登録のリンクをクリック
      click_link '新規登録'
      # リンククリック後のページが新規登録画面か？
      expect(current_path).to eq(new_customer_registration_path)
    end
  end
end

describe '登録～注文' do
  describe 'カスタマー新規登録' do
    # context内のテストを実行する前に行う事
    
    context "トップページー会員情報更新ー注文ー退会" do
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product, genre: genre) }
      let!(:product2) { create(:product2, genre: genre) }
      let!(:customer) { create(:customer) }
      let!(:admin) { create(:admin) }
      before do
        visit new_customer_session_path
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end
      it "トップページ～会員情報更新" do
        click_link "マイページ"
        click_link "編集する"
        fill_in 'customer[last_name]', with: "棚橋"
        fill_in 'customer[first_name]', with: "弘至"
        fill_in 'customer[last_name_kana]', with: "タナハシ"
        fill_in 'customer[first_name_kana]', with: "ヒロシ"
        fill_in 'customer[postcode]', with: "1234567"
        fill_in 'customer[address]', with: "東京都"
        fill_in 'customer[tel]', with: "09011112222"
        fill_in 'customer[email]', with: "tanahashi@gmail.com"

        click_button "編集内容を保存する"

        find_all('a')[6].click

        fill_in "address[postcode]", with: "8880000"
        fill_in "address[address]", with: "埼玉県"
        fill_in "address[destination]", with: "真壁"

        click_button "登録する"

        expect(page).to have_content '8880000'
        expect(page).to have_content '埼玉県'
        expect(page).to have_content '真壁'

        visit root_path

        click_link product.name
        select "2", from: 'cart_item[piece]'
        click_button "カートに入れる"
        click_link "買い物を続ける"
        click_link product2.name
        select "3", from: 'cart_item[piece]'
        # buttonならbutton
        click_button "カートに入れる"
        # aの場合link
        click_link "情報入力に進む"
        # radiobuttonをidで選択
        choose "payment_1"
        choose "address_新しいお届け先"
        fill_in "postcode", with: "9990000"
        fill_in "new_address", with: "東京都千代田区"
        fill_in "destination", with: "棚橋"
        click_button "確認画面へ進む"

        expect(page).to have_content product.name
        expect(page).to have_content product2.name

        click_button "注文を確定する"

        expect(page).to have_content 'ご注文ありがとうございました。'

        click_link "マイページ"

        find_all('a')[7].click

        find_all('a')[4].click

        visit root_path

        click_link product.name
        select "2", from: 'cart_item[piece]'
        click_button "カートに入れる"
        click_link "買い物を続ける"
        click_link product2.name
        select "3", from: 'cart_item[piece]'
        # buttonならbutton
        click_button "カートに入れる"
        # aの場合link
        click_link "情報入力に進む"
        # radiobuttonをidで選択
        choose "payment_0"
        choose "address_既存の住所"
        select "8880000埼玉県", from: "pre_address"
        click_button "確認画面へ進む"

        click_link "マイページ"

        find_all('a')[6].click

        expect(page).to have_content '9990000'
        expect(page).to have_content '東京都千代田区'
        expect(page).to have_content '真壁'

        click_link "マイページ"

        click_link "編集する"

        click_link "退会する"

        click_link "退会する"

        expect(page).to have_content '新規登録'

        click_link "ログイン"

        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'

        page(current_path).to eq(new_customer_session_path)

        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'

        click_link "会員一覧"

        expect(page).to have_content '無効'

        click_link "棚橋弘至"

        expect(page).to have_content '1234567'
        expect(page).to have_content '東京都'
        expect(page).to have_content '09011112222'

        click_link "ログアウト"

      end
    end
  end
end