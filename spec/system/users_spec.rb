require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do
  it 'ログインしていない場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    # expect(current_path).to eq "/users/sign_in"
      expect(current_path).to eq new_user_session_path
  end

  it '新規登録に成功し、トップページに遷移する' do
    # サインインページへ移動する
    visit  new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path

    # 新規登録ボタンをクリックする
    click_on("新規登録")

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_nickname', with: "aaa"
    fill_in 'user_email', with: "a@a"
    fill_in 'user_password', with: "a1500095"
    fill_in 'user_password_confirmation', with: "a1500095"

    # ログインボタンをクリックする
    click_on("Sign up")

    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end

  it '新規登録に失敗し、再び新規登録ページに遷移する' do
    # サインインページへ移動する
    visit  new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path

    # 新規登録ボタンをクリックする
    click_on("新規登録")

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_nickname', with: "aaa"
    fill_in 'user_email', with: "a@a"
    fill_in 'user_password', with: "a1500095"
    fill_in 'user_password_confirmation', with: "test"

    # ログインボタンをクリックする
    click_on("Sign up")

    # 新規登録ページに戻ってきていることを確認する
    expect(current_path).to eq "/users"
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
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
  end
  
  it 'ログインに失敗し、再びサインインページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # トップページに遷移させる
    visit  root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path

    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: "test"
    fill_in 'user_password', with: "test"

    # ログインボタンをクリックする
    click_on("Log in")

    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq  new_user_session_path
  end
end