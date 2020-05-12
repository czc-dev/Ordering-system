FactoryBot.define do
  factory :employee do
    fullname { Gimei.kanji }
    username { Faker::Internet.username(specifier: 4..64, separators: %w[_]) }
    password { 'password' }
    password_confirmation { 'password' }
  end

  trait :administrator do
    fullname { 'administrator' }
    username { 'admin' }
    password { 'administrator' }
    password_confirmation { 'administrator' }
  end
end
