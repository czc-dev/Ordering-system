FactoryBot.define do
  factory :inspection do
    canceled { false }
    status_id { 0 }
    urgent { false }
    inspection_detail { InspectionDetail.all.sample }

    # belongs_to
    order
  end

  factory :order do
    canceled { false }
    may_result_at { false }
    status_id { 0 }

    # belongs_to
    patient

    after(:create) do |order, _evaluator|
      create_list(:inspection, 10, order: order)
    end
  end

  factory :patient do
    birth { Faker::Date.birthday(0, 100) }
    gender_id { rand(0..2) }
    name { Faker::Name.name }

    after(:create) do |patient, _evaluator|
      create_list(:order, 1, patient: patient)
    end
  end
end
