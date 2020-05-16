FactoryBot.define do
  factory :employee do
    fullname { Gimei.kanji }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    association :organization
  end

  trait :administrator do
    fullname { 'administrator' }
    email { Faker::Internet.email(name: 'administrator') }
    password { 'administrator' }
    password_confirmation { 'administrator' }

    association :organization
  end
end
