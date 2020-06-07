FactoryBot.define do
  factory :patient do
    gimei = Gimei.name
    birth { Faker::Date.birthday(min_age: 0, max_age: 100) }
    gender_id { gimei.male? ? 1 : 2 }
    name { gimei.kanji }
    association :organization

    factory :patient_with_exams do
      transient do
        orders_count { 1 }
        exams_count { 10 }
      end

      after(:create) do |patient, evaluator|
        orders = create_list(:order, evaluator.orders_count, patient: patient)
        create_list(:exam, evaluator.exams_count, order: orders.first)
      end
    end
  end
end
