FactoryBot.define do
  factory :exam do
    canceled { false }
    status_id { 0 }
    urgent { false }
    exam_item { ExamItem.all.sample }

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
      create_list(:exam, 10, order: order)
    end
  end

  factory :patient do
    gimei = Gimei.name
    birth { Faker::Date.birthday(min_age: 0, max_age: 100) }
    gender_id { gimei.male? ? 1 : 2 }
    name { gimei.kanji }

    after(:create) do |patient, _evaluator|
      create_list(:order, 1, patient: patient)
    end
  end
end
