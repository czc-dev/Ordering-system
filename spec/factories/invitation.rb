FactoryBot.define do
  factory :invitation do
    token { SecureRandom.alphanumeric(Invitation::TOKEN_SIZE) }
    expired_at { nil }
    revoked_at { nil }

    trait :with_organization do
      association :organization
    end
  end
end
