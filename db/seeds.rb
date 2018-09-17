require_relative 'seeds/inspection_details'
require_relative 'seeds/inspection_sets'

# Calculate age from birthday with timezone Asia/Tokyo
# Reference:
#   https://stackoverflow.com/questions/819263/get-persons-age-in-ruby
def age(dob)
  now = Time.zone.now
  now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
end

# Reference helper
def details
  InspectionSet.all.sample.inspection_details
end

10.times do
  b = Faker::Date.birthday(0, 100)
  p = Patient.create!(
    name: Faker::Name.name,
    age: age(b),
    birth: b,
    gender_id: rand(0..2)
  )
  p.orders.create!(may_result_at: Faker::Date.backward(30)).tap do |o|
    details.each do |d|
      o.inspections.create!(inspection_detail: d)
    end
  end
end
