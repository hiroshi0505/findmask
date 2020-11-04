class Like < ApplicationRecord
  validates :user_id, {presence: true}
  validates :tweet_id, {presence: true}
end