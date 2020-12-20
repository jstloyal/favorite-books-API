FactoryBot.define do
  factory :user do
    name { Faker::Internet.name }
    nickname { Faker::Internet.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
