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
    context '新規登録画面に遷移' do
      before do
        # factoriesで作ったcustomerを@customerに代入（楽だから）
        @customer = build(:customer)

        # new_customer_registration_pathに移動
        visit new_customer_registration_path
      end
      it '新規登録' do
        # フォームに代入
        fill_in 'customer[last_name]', with: @customer.last_name
        fill_in 'customer[first_name]', with: @customer.first_name
        fill_in 'customer[last_name_kana]', with: @customer.last_name_kana
        fill_in 'customer[first_name_kana]', with: @customer.first_name_kana
        fill_in 'customer[postcode]', with: @customer.postcode
        fill_in 'customer[address]', with: @customer.address
        fill_in 'customer[tel]', with: @customer.tel
        fill_in 'customer[email]', with: @customer.email
        fill_in 'customer[password]', with: @customer.password
        fill_in 'customer[password_confirmation]', with: @customer.password_confirmation
        # 新規登録ボタンをクリック
        click_button '新規登録'

        # ボタンを押した後のページ（current_path）がroot_pathであるか？
        expect(current_path).to eq(root_path)
      end
    end
    context "トップページから商品詳細画面へ" do
      let(:product) { create(:product) }
      before do
        @customer = create(:customer)
        visit new_customer_session_path
        fill_in 'customer[email]', with: @customer.email
        fill_in 'customer[password]', with: @customer.password
        click_button 'ログイン'
      end
      it "商品詳細画面に遷移" do
        click_link product.name

        expect(current_page).to eq(product_path)
      end
    end
  end
end