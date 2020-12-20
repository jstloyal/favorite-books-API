FactoryBot.define do
  factory :book do
    title { Faker::Internet.title }
    description { Faker::Internet.title }
    author { Faker::Internet.title }
    genre { Faker::Internet.title }
  end
end