class Comment < ApplicationRecord
  belongs_to :user  # usersテーブルとのアソシエーション
  belongs_to :tweet  # tweetsテーブルとのアソシエーション

  validates :text, presence: true
end
