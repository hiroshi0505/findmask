# アプリ名
# 説明（何が出来る物なのか）
# 使い方
# 構築やインストール方法
# ライセンス
# 作者
# 「ユーザーはこんな課題を持っているかも」
# 「もっとこうなるとユーザーに喜んでもらえるのでは」という問い
# 以下の設定方法を参考に、ペルソナを考えてみましょう。
# 設定方法
# 性別・年齢
# 職業
# 趣味
# 日頃の生活
# ペルソナの課題
# 解決したい課題 	なぜその課題解決が必要なのか 課題を解決する実装の内容

## 🌐 App URL

### **デプロイ後、urlのリンクを貼る**  


# テーブル設計

## users テーブル

| Column         | Type   | Options     |
|----------------|--------|-------------|
| nickname       | string | null: false |
| email          | string | null: false |
| password       | string | null: false |

### Association
- has_many :tweets
- has_many :comments

## tweets テーブル

| Column           | Type    | Options     |
|------------------|---------|-------------|
| text             | text    | null: false |
| image            | text    | null: false |
| user_id          | integer | null: false |

### Association
- belongs_to :user
- has_many :comments
- has_one_attached :image

## comments テーブル

| Column   | Type    | Options     |
|----------|---------|-------------|
| text     | test    | null: false |
| user_id  | integer | null: false |
| tweet_id | integer | null: false |

### Association
- belongs_to :user
- belongs_to :tweet