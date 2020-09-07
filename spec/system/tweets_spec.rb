require 'rails_helper'

RSpec.describe "投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
  context '投稿に失敗するとき' do
    it 'textとimageを空で送信をした場合、投稿に失敗する' do
      # サインインする
      sign_in(@user)
      # 投稿ページへ遷移する
      click_on('投稿する')
      # SENDをクリックする
      click_on("SEND")
      # アラートが出ることを確認する
      expect(page.driver.browser.switch_to.alert.text).to eq "内容に間違いはございませんか？"
      # okをおす
      page.driver.browser.switch_to.alert.accept
      visit new_tweet_path
      # 送信した値がDBに保存されていないことを確認する
      not change { Tweet.count }
      # 現在のページが投稿ページであることを確認する
      expect(current_path).to eq "/tweets"
    end
    it 'textを入力するがimageが空の為、投稿に失敗する' do
      # サインインする
      sign_in(@user)
      # 投稿ページへ遷移する
      click_on('投稿する')
      # テキストフォームに「テスト」と入力する
      post = "テスト"
      fill_in 'tweet_text', with: post
      # SENDをクリックする
      click_on("SEND")
      # アラートが出ることを確認する
      expect(page.driver.browser.switch_to.alert.text).to eq "内容に間違いはございませんか？"
      # okをおす
      page.driver.browser.switch_to.alert.accept
      visit new_tweet_path
      # 送信した値がDBに保存されていないことを確認する
      not change { Tweet.count }
      # 現在のページが投稿ページであることを確認する
      expect(current_path).to eq "/tweets"
    end
    it 'imageを入力するがtextが空の為、投稿に失敗する' do
      # サインインする
      sign_in(@user)
      # 投稿ページへ遷移する
      click_on('投稿する')
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('tweet[image]', image_path, make_visible: true)
      # SENDをクリックする
      click_on("SEND")
      # アラートが出ることを確認する
      expect(page.driver.browser.switch_to.alert.text).to eq "内容に間違いはございませんか？"
      # okをおす
      page.driver.browser.switch_to.alert.accept
      visit new_tweet_path
      # 送信した値がDBに保存されていないことを確認する
      not change { Tweet.count }
      # 現在のページが投稿ページであることを確認する
      expect(current_path).to eq "/tweets"
    end
  end
  context '投稿に成功する' do
    it 'imageとtextの両方を送信すると投稿に成功する' do
      # サインインする
      sign_in(@user)
      # 投稿ページへ遷移する
      click_on('投稿する')
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('tweet[image]', image_path, make_visible: true)
      # テキストフォームに「テスト」と入力する
      post = "テスト"
      fill_in 'tweet_text', with: post
      # SENDをクリックする
      click_on("SEND")
      # アラートが出ることを確認する
      expect(page.driver.browser.switch_to.alert.text).to eq "内容に間違いはございませんか？"
      # okをおす
      page.driver.browser.switch_to.alert.accept
      visit tweets_path
      # SENDをクリックし、送信した値がDBに保存されていないことを確認する
      change { Tweet.count }.by(1)
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq tweets_path
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
      # 送信したtextがブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end
  end
end

RSpec.describe "投稿機能", type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
  end
  it 'imageとtextの両方を送信すると投稿に成功し、投稿した画像を編集・削除できる' do
    visit new_user_session_path
    fill_in "user[email]", with: @tweet.user.email
    fill_in "user[password]", with: @tweet.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    click_on('マイページ')
    # 編集ページへ遷移する
    click_on('＜編集＞')
    # アラートが出ることを確認する
    expect(page.driver.browser.switch_to.alert.text).to eq "編集しますか？"
    # okをおす
    page.driver.browser.switch_to.alert.accept
    visit edit_tweet_path
    # SENDをクリックする
    click_on('SEND')
    # アラートが出ることを確認する
    expect(page.driver.browser.switch_to.alert.text).to eq "内容に間違いはございませんか？"
    # okをおす
    page.driver.browser.switch_to.alert.accept
    visit "/tweets/#{@tweet.id}"
    # 送信した値がDBに上書きされていることを確認する
    not change { Tweet.count }
    # 現在のページが投稿一覧ページであることを確認する
    expect(current_path).to eq "/tweets/#{@tweet.id}"
    # 投稿を削除する
    click_on('＜削除＞')
    # アラートが出ることを確認する
    expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除しますか？"
    # okをおす
    page.driver.browser.switch_to.alert.accept
    visit "/tweets"
    # ユーザーモデルのカウントが1下がることを確認する
    change { Tweet.count }.by(-1)
    # 現在のページが投稿一覧ページであることを確認する
    expect(current_path).to eq "/tweets"
  end
end