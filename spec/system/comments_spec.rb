require 'rails_helper'

RSpec.describe "メッセージ投稿機能", type: :system do
  # before do
  #   # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
  #   @comment = FactoryBot.create(:comment)
  # end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿した内容が表示されている' do
      # サインインする
      sign_in()
      visit tweets_path
      # 作成されたチャットルームへ遷移する
      click_on('＜詳細＞')

      # 値をテキストフォームに入力する
      post = "テスト"
      fill_in 'textarea', with: post
      click_on('submit')
      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      # expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end
    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@user)

      # 作成されたチャットルームへ遷移する
      click_on(@comment.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する

      # 送信した値がDBに保存されていることを確認する

      # 投稿一覧画面に遷移していることを確認する

      # 送信した画像がブラウザに表示されていることを確認する

    end
    it 'テキストと画像の投稿に成功すること' do
      # サインインする
      sign_in(@user)

      # 作成されたチャットルームへ遷移する
      click_on(@comment.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する

      # 値をテキストフォームに入力する

      # 送信した値がDBに保存されていることを確認する

      # 送信した値がブラウザに表示されていることを確認する

      # 送信した画像がブラウザに表示されていることを確認する

    end
  end
end