FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
  end

  factory :category do
    name Faker::Lorem.words(2).join(' ')
  end

  factory :link do
    url Faker::Internet.url
    name Faker::Lorem.words(5).join(' ')
    user
    category
  end
end
