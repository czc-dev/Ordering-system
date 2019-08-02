require_relative 'seeds/inspection_details'
require_relative 'seeds/inspection_sets'

case Rails.env
when 'development'
  # Reference helper
  def details
    InspectionSet.all.sample.inspection_details
  end

  # patients
  10.times do
    b = Faker::Date.birthday(0, 100)
    p = Patient.create!(
      name: Faker::Name.name,
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
    username: Rails.application.credentials.admin[:username],
    password: Rails.application.credentials.admin[:password]
  )
end
