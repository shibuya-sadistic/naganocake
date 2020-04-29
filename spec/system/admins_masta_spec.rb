require 'rails_helper'

describe "アドミンのテスト" do
	describe "ログイン" do
		context "ログイン画面に遷移" do
			let(:admin) { create(:admin)}
			before do
				visit new_admin_session_path
			end
		 	it "ログインできる" do
		 		fill_in 'admin[email]', with: admin.email
		 		fill_in 'admin[password]', with: admin.password
		 		click_button 'ログイン'

		 		expect(current_path).to eq(admins_top_path)
			end
			it "ログインできない" do
				fill_in 'admin[email]', with: ""
		 		fill_in 'admin[password]', with: ""
		 		click_button 'ログイン'

		 		expect(current_path).to eq(new_admin_session_path)
			end
		end
		context "ジャンル画面への遷移と登録" do
			let(:admin) { create(:admin)}
			before do
				visit new_admin_session_path
				fill_in 'admin[email]', with: admin.email
			 	fill_in 'admin[password]', with: admin.password
			 	click_button 'ログイン'
			end
			it "ジャンル画面に移動" do
				click_link "ジャンル管理"
				expect(current_path).to eq(admins_genres_path)
			end
			it "ジャンルを追加" do
				click_link "ジャンル管理"
				fill_in "genre[name]", with: "ケーキ"
				choose "有効"
				click_button "追加"
				expect(page).to have_content 'ケーキ'
				expect(page).to have_content '有効'
			end
		end
		context "商品画面への遷移と登録" do
			let(:admin) { create(:admin)}
			let!(:genre) { create(:genre)}
			before do
				visit new_admin_session_path
				fill_in 'admin[email]', with: admin.email
			 	fill_in 'admin[password]', with: admin.password
			 	click_button 'ログイン'
			end
			it "商品画面に移動" do
				click_link "商品一覧"
				expect(current_path).to eq(admins_products_path)
			end
			it "商品を追加→ログアウト" do
				click_link "商品一覧"
				click_link "+"
				fill_in "product[name]", with: "シフォンケーキ"
				fill_in "product[introduction]", with: "最高の一品"
				select genre.name, from: 'ジャンル'
				fill_in "product[price]", with: "3000"
				select "販売中", from: '販売ステータス'
				click_button "新規登録"

				expect(page).to have_content 'シフォンケーキ'
				click_link "商品一覧"
				expect(page).to have_content 'シフォンケーキ'
				click_link "+"
				fill_in "product[name]", with: "ガトーショコラ"
				fill_in "product[introduction]", with: "最高の一品？"
				select genre.name, from: 'ジャンル'
				fill_in "product[price]", with: "3000"
				select "販売中", from: '販売ステータス'
				click_button "新規登録"

				expect(page).to have_content 'ガトーショコラ'
				click_link "商品一覧"
				expect(page).to have_content 'ガトーショコラ'
				click_link "ログアウト"

				expect(current_path).to eq(root_path)
			end
		end
	end
end