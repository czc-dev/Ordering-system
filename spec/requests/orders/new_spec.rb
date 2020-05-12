# frozen_string_literal: true

RSpec.describe 'Orders GET /patients/:patient_id/orders/new', type: :request, js: true do
  let(:patient) { create(:patient) }

  include_context :act_login_as_employee

  subject { get new_patient_order_path(patient.id) }

  it 'can show all ExamSet' do
    subject
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it 'can show all ExamItem' do
    subject
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it 'returns status code 200' do
    subject
    expect(response).to have_http_status(200)
  end
end
