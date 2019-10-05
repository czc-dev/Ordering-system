# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Exams DELETE /exams/:id', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:exam) { order.exams.first }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { delete exam_path(exam.id) }

  it 'deletes(discards) exam' do
    expect(Exam.with_discarded.find_by(id: exam.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    expect(Exam.find_by(id: exam.id)).to be_nil
  end

  it { should redirect_to(order_exams_url(exam.order.id)) }
end
