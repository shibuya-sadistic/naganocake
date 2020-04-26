require 'rails_helper'

describe '管理者のログイン' do
	let(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
    end
	context 'ログイン画面に遷移' do
		let(:test_admin) { admin }
		it 'ログインに成功する' do
		  fill_in 'admin[email]', with: test_admin.email
          fill_in 'admin[password]', with: test_admin.password
          click_button 'ログイン'

          expect(current_path).to eq(admins_top_path)
          #expect(page).to have_content 'successfully'
		end
		it 'ログインに失敗する' do
		  fill_in 'admin[email]', with: ''
          fill_in 'admin[password]', with: ''
          click_button 'ログイン'

          expect(current_path).to eq(new_admin_session_path)
		end
	end
end

describe 'トップ画面のテスト' do
	let(:customer) { create(:customer) }
  	let!(:order) { create(:order, customer: customer) }
  	let!(:order_item) { create(:order_item, order: order) }
	before do
      visit admins_top_path
    end
	context '注文履歴一覧への遷移' do
		it '注文履歴一覧と表示される' do
			visit admins_orders_path
			expect(page).to have_content('注文一覧画面')
		end
		it '注文詳細画面のリンクが表示される' do
        	expect(page).to have_link order.created_at, href: admins_order_path(order)
		end
	end
end

describe '注文詳細画面のテスト' do
	before do
      visit admins_order_path
  	end
	context '表示の確認' do
		　it '注文詳細画面と表示される' do
			expect(page).to have_content('注文詳細画面')
		　end
	end
	context 'ステータス更新の確認' do

		it '注文ステータスが入金確認、製作ステータスが製作待ちに更新される' do
		end
		it '注文ステータスが製作中に更新される' do
		#製作ステータスが製作中に更新される
		end
		it '注文ステータスが発送準備中に更新される' do
		#製作ステータスが製作完了に更新される
		end
		it '注文ステータスが発送済みに更新される' do

		end
	end
end

describe '管理者のログアウト' do
	it 'ログアウトに成功する' do
		click_button 'ログアウト'

		expect(current_path).to eq(new_admin_session_path)
		end
	end
end


