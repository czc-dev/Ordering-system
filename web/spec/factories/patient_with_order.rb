FactoryBot.define do
  factory :inspection_detail do
    formal_name { '検査名' }
    abbreviation { 'inspection name' }
  end

  factory :inspection do
    canceled { false }
    status_id { 0 }
    urgent { false }

    # belongs_to
    order
    inspection_detail
  end

  factory :order do
    canceled { false }
    may_result_at { false }
    status_id { 0 }

    # belongs_to
    patient

    after(:create) do |order, _evaluator|
      create_list(:inspection, 1, order: order)
    end
  end

  factory :patient do
    age { 20 }
    birth { Faker::Date.birthday(0, 100) }
    gender_id { rand(0..2) } # 他
    name { Faker::Name.name }

    after(:create) do |patient, _evaluator|
      create_list(:order, 1, patient: patient)
    end
  end
end
