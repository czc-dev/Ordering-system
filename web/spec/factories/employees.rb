FactoryBot.define do
  factory :employee do
    fullname { Faker::Name.name }
    username { Faker::Internet.username }
    password { 'employee' }
    password_confirmation { 'employee' }
  end

  end
end
