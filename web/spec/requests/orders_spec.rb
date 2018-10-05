require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  let(:patient) { create(:patient) }

  describe '/patients/:patient_id/orders' do
    before { get "/patients/#{patient.id}/orders" }

    it "can show patient's orders exclude canceled one" do
      expect(patient.orders.where(canceled: false)).to eq(assigns[:orders])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
