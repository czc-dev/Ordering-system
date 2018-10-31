FactoryBot.define do
  factory :employee do
    fullname { Faker::Name.name }
    username { Faker::Internet.username }
    password_digest { 'fa5473530e4d1a5a1e1eb53d2fedb10c' } # 'employee'
  end
end
