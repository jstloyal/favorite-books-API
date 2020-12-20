FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Internet.name }
    nickname { Faker::Internet.name }
  end
end
