FactoryBot.define do
  factory :inspection_detail do
    # it feels same that relation of inspection's formal_name, abbreviation
    # between element, element_symbol
    formal_name { Faker::Science.element }
    abbreviation { Faker::Science.element_symbol }
  end
end
