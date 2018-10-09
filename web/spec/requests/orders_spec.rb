require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  # this will create patient
  # with 1 order and 10 inspections with its detail
  let(:patient) { create(:patient) }

  describe 'GET /patients/:patient_id/orders' do
    before { get "/patients/#{patient.id}/orders" }

    it "can show patient's orders exclude canceled one" do
      expect(patient.orders.where(canceled: false)).to eq(assigns[:orders])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /patients/:patient_id/orders/new' do
    before { get "/patients/#{patient.id}/orders/new" }

    it 'can show all InspectionSet' do
      # TODO: define InspectionSet
      expect(InspectionSet.all).to eq(assigns[:sets])
    end

    it 'can show all InspectionDetail' do
      expect(InspectionDetail.all).to eq(assigns[:details])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /patients/:patient_id/orders' do
    let(:valid_params) do
      { order: { inspections: (1..10).to_a, may_result_at: Time.zone.now + 10.days } }
    end
    let(:invalid_params) do
      { order: { may_result_at: Time.zone.now + 10.days } }
    end

    context 'when the request is valid' do
      before { post "/patients/#{patient.id}/orders", params: valid_params }

      it 'creates a order' do
        expect(Order.last).to eq(assigns[:order])
      end

      it 'returns status code 302(Found)' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when no inspections selected' do
      before { post "/patients/#{patient.id}/orders", params: invalid_params }

      # TODO: assert re-rendered orders#new

      it 'returns status code 400(Bad request)' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
