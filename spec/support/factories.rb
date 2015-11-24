FactoryGirl.define do
  factory :user do
    email  Faker::Internet.email
  end

  factory :category do
    name Faker::Lorem.words(2).join(' ')
  end

  factory :link do
    url Faker::Internet.url
    user
    category
  end
end
