FactoryBot.define do
  factory :patient do
    gimei = Gimei.name
    birth { Faker::Date.birthday(min_age: 0, max_age: 100) }
    gender_id { gimei.male? ? 1 : 2 }
    name { gimei.kanji }
  end
end
