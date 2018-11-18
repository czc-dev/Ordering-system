require 'rails_helper'

RSpec.describe 'Patient API', type: :request do
  let!(:patients) { create_list(:patient, 5) }
  let(:employee) { create(:employee) }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /patients' do
    before { get '/patients' }

    it 'can show all patient' do
      expect(Patient.all).to eq(assigns[:patients])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /patients/:id' do
    pending 'data should not destroy'
  end
end
