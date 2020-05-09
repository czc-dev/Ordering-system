# frozen_string_literal: true

RSpec.describe 'Orders GET /patients/:patient_id/orders/new', type: :request, js: true do
  let(:patient) { create(:patient) }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get "/patients/#{patient.id}/orders/new" }

  it 'can show all ExamSet' do
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it 'can show all ExamItem' do
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
