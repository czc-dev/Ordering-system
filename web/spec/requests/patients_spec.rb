require 'rails_helper'

RSpec.describe 'Patient API', type: :request do
  let!(:patients) { create_list(:patient, 5) }

  describe 'GET /patients' do
    before { get '/patients' }

    it 'can show all patient' do
      expect(Patient.all).to eq(assigns[:patients])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
