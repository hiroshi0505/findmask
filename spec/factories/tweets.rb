FactoryBot.define do
  factory :tweet do
    text        {Faker::Lorem.sentence}
    association :user 
  end
end