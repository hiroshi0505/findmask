require 'rails_helper'

RSpec.describe "投稿機能", type: :system do
  
  context '投稿に失敗したとき' do
    it 'textとimageが空で送信をした場合、投稿に失敗すること' do
      # サインインする
      @user = FactoryBot.create(:user)
      # サインインページへ移動する
      visit  new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
      click_on("Log in")
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 一覧ページに移動する
      visit tweets_path
      # 投稿ページへ遷移する
      click_on('投稿する')
      # 送信した値がDBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Tweet.count }
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq "/tweets"
    end
    it 'textを入力するがimageが空の為、投稿に失敗すること' do
      # サインインする
      @user = FactoryBot.create(:user)
      # サインインページへ移動する
      visit  new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
      click_on("Log in")
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 一覧ページに移動する
      visit tweets_path
      # 投稿ページへ遷移する
      click_on('投稿する')
      # 値をテキストフォームに入力する
      post = "テスト"
      fill_in 'tweet_text', with: post
      # 送信した値がDBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Tweet.count }
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq "/tweets"
    end
    it 'imageを入力するがtextが空の為、投稿に失敗すること' do
      # サインインする
      @user = FactoryBot.create(:user)
      # サインインページへ移動する
      visit  new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
      click_on("Log in")
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 一覧ページに移動する
      visit tweets_path
      # 投稿ページへ遷移する
      click_on('投稿する')
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('tweet[image]', image_path, make_visible: true)
      # 送信した値がDBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Tweet.count }
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq "/tweets"
    end
  end
  context '投稿に成功したとき' do
    it '投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      @user = FactoryBot.create(:user)
      # サインインページへ移動する
      visit  new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
      click_on("Log in")
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 一覧ページに移動する
      visit tweets_path
      # 投稿ページへ遷移する
      click_on('投稿する')
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('tweet[image]', image_path, make_visible: true)
      # 値をテキストフォームに入力する
      post = "テスト"
      fill_in 'tweet_text', with: post
      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq tweets_path
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
  end
end