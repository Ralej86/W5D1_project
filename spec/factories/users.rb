FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    password { Faker::Dog.breed }
  end
end
