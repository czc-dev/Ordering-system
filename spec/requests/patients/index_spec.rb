# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Patient GET /patients', type: :request, js: true do
  let!(:patients) { create_list(:patient, 5) }
  let(:patient) { patients.first }
  let(:patient_id) { patient.id }
  let(:employee) { create(:employee) }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get '/patients' }

  it 'can show all patient' do
    expect(Patient.all).to eq(assigns[:patients])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
