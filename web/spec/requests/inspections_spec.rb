require 'rails_helper'

RSpec.describe 'Inspections', type: :request do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:inspection) { order.inspections.first }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /orders/:order_id/inspections' do
    before { get "/orders/#{order.id}/inspections" }

    it "can show order's inspections exclude canceled one" do
      expect(order.inspections.where(canceled: false)).to eq(assigns[:inspections])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /orders/:order_id/inspections/new' do
    before { get new_order_inspection_path(order.id) }

    it 'can show all InspectionSet' do
      # TODO: define InspectionSet; Current is nil
      expect(InspectionSet.all).to eq(assigns[:sets])
    end

    it 'can show all InspectionDetail' do
      expect(InspectionDetail.all).to eq(assigns[:details])
    end

    it { should render_template('new') }
  end

  describe 'POST /orders/:order_id/inspections' do
    context 'when the request is valid' do
      let(:valid_params) do
        { order: { inspections: (1..10).to_a } }
      end
      before { post order_inspections_path(order.id), params: valid_params }

      it 'creates a order' do
        expect(Order.last).to eq(assigns[:order])
      end

      it 'creates "Added" log' do
        expect(Log.last.content).to match(/追加/)
      end

      it { should redirect_to(order_inspections_path(Order.last)) }
    end

    context 'when no inspections selected' do
      let(:invalid_params) do
        { order: { inspections: [] } }
      end
      before { post order_inspections_path(order.id), params: invalid_params }

      it { should render_template('new') }

      it 'returns status code 400(Bad request)' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /inspections/:id/edit' do
    before { get edit_inspection_path(inspection.id) }

    it "can show inspection, which is found by id" do
      expect(Inspection.find(inspection.id)).to eq(assigns[:inspection])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH/PUT /inspection/:id/' do
    context 'when request is valid' do
      let(:valid_params) do
        { inspection: { canceled: true, urgent: true, status_id: 5 } }
      end
      before { put inspection_path(inspection.id), params: valid_params }

      it 'updates inspetion' do
        i = Inspection.find(inspection.id)
        expect(i.canceled?).to be_truthy
        expect(i.urgent?).to be_truthy
        expect(i.status_id).to eq(5)
      end

      it 'creates "Changed" log' do
        expect(Log.last.content).to match(/変更/)
      end

      it { should redirect_to(order_inspections_url(patient.id)) }
    end
  end

  describe 'DELETE /inspections/:id' do
    pending 'data should not destroy'
  end
end
