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