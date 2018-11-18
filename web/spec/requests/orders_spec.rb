require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  # this will create patient
  # with 1 order and 10 inspections with its detail
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }


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

      it 'creates "Created" log' do
        expect(Log.last.content).to match(/作成/)
      end

      it { should redirect_to(order_inspections_path(Order.last)) }
    end

    context 'when no inspections selected' do
      before { post "/patients/#{patient.id}/orders", params: invalid_params }

      it { should render_template('new') }

      it 'returns status code 400(Bad request)' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /orders/:id/edit' do
    before { get "/orders/#{order.id}/edit" }

    it "can show order, which is found by id" do
      expect(Order.find(order.id)).to eq(assigns[:order])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH/PUT /orders/:id/' do
    context 'when request is valid' do
      let(:valid_params) do
        {
          order: { canceled: true }
        }
      end
      before { put order_path(order.id), params: valid_params }

      it 'updates order' do
        expect(Order.find(order.id).canceled?).to be_truthy
      end

      it 'creates "Changed" log' do
        expect(Log.last.content).to match(/変更/)
      end

      it { should redirect_to(patient_orders_path(patient.id)) }
    end
  end

  describe 'DELETE /orders/:id' do
    pending 'data should not destroy'
  end
end
