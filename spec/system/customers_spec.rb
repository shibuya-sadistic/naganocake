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

describe 'カスタマー認証のテスト' do
  describe 'カスタマー新規登録' do
    # context内のテストを実行する前に行う事
    before do
      # factoriesで作ったcustomerを@customerに代入（楽だから）
      # new_customer_registration_pathに移動
      visit new_customer_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        # フォームに代入
        fill_in 'customer[last_name]', with: "棚橋"
        fill_in 'customer[first_name]', with: "弘至"
        fill_in 'customer[last_name_kana]', with: "タナハシ"
        fill_in 'customer[first_name_kana]', with: "ヒロシ"
        fill_in 'customer[postcode]', with: "1234567"
        fill_in 'customer[address]', with: "東京都"
        fill_in 'customer[tel]', with: "09011112222"
        fill_in 'customer[email]', with: "tanahashi@gmail.com"
        fill_in 'customer[password]', with: "password"
        fill_in 'customer[password_confirmation]', with: "password"
        # 新規登録ボタンをクリック
        click_button '新規登録'

        # ボタンを押した後のページ（current_path）がroot_pathであるか？
        expect(current_path).to eq(root_path)
      end
      it '新規登録に失敗する' do
        # フォームに空白を代入
        fill_in 'customer[last_name]', with: ""
        fill_in 'customer[first_name]', with: ""
        fill_in 'customer[last_name_kana]', with: ""
        fill_in 'customer[first_name_kana]', with: ""
        fill_in 'customer[postcode]', with: ""
        fill_in 'customer[address]', with: ""
        fill_in 'customer[tel]', with: ""
        fill_in 'customer[email]', with: ""
        fill_in 'customer[password]', with: ""
        fill_in 'customer[password_confirmation]', with: ""
        click_button '新規登録'

        # errorを含んだhtml要素があるか？
        expect(page).to have_content 'エラー'
      end
    end
  end

  describe 'ユーザーログイン' do
    # customerを作成
    let(:customer) { create(:customer) }
    before do
      visit new_customer_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test) { customer }
      it 'ログインに成功する＋ヘッダーが変化' do
        fill_in 'customer[email]', with: test.email
        fill_in 'customer[password]', with: test.password
        click_button 'ログイン'

        expect(current_path).to eq(root_path)
        click_link 'マイページ'
      end

      it 'ログインに失敗する' do
        fill_in 'customer[email]', with: ""
        fill_in 'customer[password]', with: ""
        click_button 'ログイン'

        expect(current_path).to eq(new_customer_session_path)
      end
    end
  end
end