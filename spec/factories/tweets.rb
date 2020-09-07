FactoryBot.define do
  factory :tweet do
    text        {Faker::Lorem.sentence}
    image       {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    association :user 
  end
end