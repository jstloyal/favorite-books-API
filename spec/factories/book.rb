FactoryBot.define do
  factory :book do
    title { Faker::Internet.name }
    description { Faker::Internet.name }
    author { Faker::Internet.name }
    genre { Faker::Internet.name }
  end
end