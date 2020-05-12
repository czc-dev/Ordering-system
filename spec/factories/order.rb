FactoryBot.define do
  factory :order do
    canceled { false }
    may_result_at { false }
    status_id { 0 }

    association :patient
  end
end
