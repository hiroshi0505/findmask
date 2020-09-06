require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # サインアップボタンを押す
      click_on("Sign up")
      # アラートが出ることを確認する
      expect(page.driver.browser.switch_to.alert.text).to eq "この内容で登録しますか？"
      # okをおす
      page.driver.browser.switch_to.alert.accept
      # ユーザーモデルのカウントが1上がることを確認する
      change { User.count }.by(1)
      # 現在のページがルートパスであることを確認する
      expect(current_path).to eq root_path
      # ページ内に「ログアウト」と「投稿する」ボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('投稿する')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # ページ内に新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 誤ったユーザー情報を入力する
      fill_in 'user_nickname', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      # サインアップボタンを押す
      click_on("Sign up")
      # アラートが出ることを確認する
      expect(page.driver.browser.switch_to.alert.text).to eq "この内容で登録しますか？"
      # okをおす
      page.driver.browser.switch_to.alert.accept
      # ユーザーモデルのカウントは変わらないことを確認する
      not change { User.count }
      # 現在のページが新規登録ページであることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # ページ内にログインボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # 現在のページがトップページであること確認する
      expect(current_path).to eq root_path
      # ページ内に「ログアウト」と「投稿する」ボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('投稿する')
      # 新規登録ボタンやログインボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # ページ内にログインボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # 現在のページがログインページであることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end