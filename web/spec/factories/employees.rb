FactoryBot.define do
  factory :employee do
    fullname { Faker::Name.name }
    username { 'employee' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
