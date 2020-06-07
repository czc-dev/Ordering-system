FactoryBot.define do
  factory :organization do
    name { Faker::Team.name }
    discarded_at { nil }
  end
end
