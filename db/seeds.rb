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
    b = Faker::Date.birthday(0, 100)
    gimei = Gimei.name
    p = Patient.create!(
      name: gimei.kanji,
      birth: b,
      gender_id: gimei.male? ? 1 : 2
    )
    p.orders.create!(may_result_at: Faker::Date.forward(30)).tap do |o|
      exam_items.each do |exam_item|
        o.exams.create!(exam_item: exam_item)
      end
    end
  end

  # employees
  5.times do |i|
    Employee.create(
      fullname: Gimei.kanji,
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

PaperTrail.enabled = true
