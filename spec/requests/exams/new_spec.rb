# frozen_string_literal: true

RSpec.describe 'Exams GET /orders/:order_id/exams/new', type: :request, js: true do
  let(:order) { create(:order) }

  include_context :act_login_as_employee

  subject { get new_order_exam_path(order.id) }

  it 'can show all ExamSet' do
    subject
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it 'can show all ExamItem' do
    subject
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it { is_expected.to render_template('new') }
end
