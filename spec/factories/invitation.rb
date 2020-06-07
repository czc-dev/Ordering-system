FactoryBot.define do
  factory :invitation do
    token { SecureRandom.alphanumeric(Invitation::TOKEN_SIZE) }
    expired_at { nil }
    revoked_at { nil }

    trait :with_organization do
      association :organization
    end

    trait :with_email do
      email { Faker::Internet.email }
    end

    trait :expired do
      expired_at { Time.zone.now - 1.week }
    end
  end
end
