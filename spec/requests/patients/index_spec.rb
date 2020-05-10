# frozen_string_literal: true

RSpec.describe 'Patient GET /patients', type: :request, js: true do
  let(:params) { { page: 1 } }

  include_context :act_login_as_employee

  before { create_list(:patient, 10) }

  before { get '/patients' }

  it 'can show all patient' do
    expect(assigns[:patients]).to eq(Patient.page(params[:page]))
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
