PaperTrail.enabled = false

require_relative 'seeds/exam_items'
require_relative 'seeds/exam_sets'

case Rails.env
when 'development'
  # Reference helper
  def exam_items
    ExamSet.all.sample.exam_items
  end

  # organization
  orgs = []
  2.times { orgs << Organization.create!(name: Faker::Team.name) }

  orgs.each_with_index do |org, i|
    # admin employee
    org.employees.create!(
      fullname: Gimei.kanji,
      email: "org#{i}.admin@example.com",
      password: 'admin',
      password_confirmation: 'admin',
      role: 'admin'
    )

    # mere employees
    5.times do |j|
      org.employees.create!(
        fullname: Gimei.kanji,
        email: "employee#{i}.#{j}@example.com",
        password: 'employee',
        password_confirmation: 'employee'
      )
    end

    # patients
    10.times do
      b = Faker::Date.birthday(min_age: 0, max_age: 100)
      gimei = Gimei.name
      p = org.patients.create!(
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
  end
when 'production'
  Employee.create!(
    fullname: '管理アカウント',
    email: Rails.application.credentials.admin[:email],
    password: Rails.application.credentials.admin[:password],
    role: 'admin'
  )
end

PaperTrail.enabled = true
