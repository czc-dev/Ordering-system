PaperTrail.enabled = false

require_relative 'seeds/exam_items'
require_relative 'seeds/exam_sets'

case Rails.env
when 'development'
  # Reference helper
  def exam_items
    ExamSet.all.sample.exam_items
  end

  # patients
  10.times do
    b = Faker::Date.birthday(min_age: 0, max_age: 100)
    gimei = Gimei.name
    p = Patient.create!(
      name: gimei.kanji,
      birth: b,
      gender_id: gimei.male? ? 1 : 2
    )
    p.orders.create!(may_result_at: Faker::Date.forward(days: 30)).tap do |o|
      exam_items.each do |exam_item|
        o.exams.create!(exam_item: exam_item)
      end
    end
  end

  # organization
  org = Organization.create!(name: Faker::Team.name)

  # employees
  5.times do |i|
    org.employees.create!(
      fullname: Gimei.kanji,
      email: "employee#{i}@example.com",
      password: 'employee',
      password_confirmation: 'employee'
    )
  end
when 'production'
  Employee.create!(
    fullname: '管理アカウント',
    email: Rails.application.credentials.admin[:email],
    password: Rails.application.credentials.admin[:password]
  )
end

PaperTrail.enabled = true
