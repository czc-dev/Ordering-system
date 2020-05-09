# frozen_string_literal: true

RSpec.describe 'Patient GET /patients', type: :request, js: true do
  let(:params) { { page: 1 } }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before do
    post login_path, params: { username: employee.username, password: employee.password }
    create_list(:patient, 10)
  end

  before { get '/patients' }

  it 'can show all patient' do
    expect(assigns[:patients]).to eq(Patient.page(params[:page]))
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
