require 'rails_helper'

RSpec.describe 'Inspections API', type: :request do
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }

  describe 'GET /orders/:order_id/inspections' do
    before { get "/orders/#{order.id}/inspections" }

    it "can show order's inspections exclude canceled one" do
      expect(order.inspections.where(canceled: false)).to eq(assigns[:inspections])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
