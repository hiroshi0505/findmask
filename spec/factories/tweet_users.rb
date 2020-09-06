FactoryBot.define do
  factory :tweet_user do
    association :user
    association :tweet
  end
end