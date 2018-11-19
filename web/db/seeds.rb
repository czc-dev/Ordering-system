require_relative 'seeds/inspection_details'
require_relative 'seeds/inspection_sets'

case Rails.env
when 'development'
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

  # patients
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

  # employees
  5.times do |i|
    Employee.create(
      fullname: Faker::Name.name,
      username: "employee#{i}",
      password: 'employee',
      password_confirmation: 'employee'
    )
  end
when 'production'
  Employee.create!(
    fullname: '管理アカウント',
    username: 'admin',
    password_digest: '$2a$10$qabYWHA9VllMjjY8/9jMeeUwitP4Ws4jA/FYWRSnk0mRmYomrgiOW'
  )
end
