# frozen_string_literal: true

RSpec.describe 'Exams DELETE /exams/:id', type: :request, js: true do
  let(:exam) { create(:exam) }

  include_context :act_login_as_employee

  subject { delete exam_path(exam.id) }

  it 'deletes(discards) exam' do
    subject
    expect(Exam.with_discarded.find_by(id: exam.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    subject
    expect(Exam.find_by(id: exam.id)).to be_nil
  end

  it { is_expected.to redirect_to(order_exams_url(exam.order.id)) }
end
