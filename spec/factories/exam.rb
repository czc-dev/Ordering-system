FactoryBot.define do
  factory :exam do
    canceled { false }
    status { 0 }
    urgent { false }
    submitted { false }
    exam_item { ExamItem.all.sample }

    association :order
  end
end
