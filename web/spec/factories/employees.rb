FactoryBot.define do
  factory :employee do
    fullname { Faker::Name.name }
    username { Faker::Internet.username }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
