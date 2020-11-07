crumb :root do
  link "学習ページ", root_path
end

crumb :index do
  link "投稿一覧ページ", tweets_path
  parent :root
end

crumb :usersshow do
  link "マイページ", user_path
  parent :root
end

crumb :new do
  link "投稿ページ", new_tweet_path
  parent :root
end

crumb :show do
  link "詳細ページ", tweet_path
  parent :index
end

crumb :edit do
  link "編集ページ", edit_tweet_path
  parent :index
end