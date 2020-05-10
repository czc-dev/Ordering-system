# frozen_string_literal: true

RSpec.describe 'Ajax::Orders', type: :request, js: true do
  let(:patient) { order.patient }
  let!(:order) { create(:order) }

  include_context :act_login_as_employee

  describe 'GET /ajax/orders/index' do
    context 'when params: canceled specified' do
      before { get ajax_orders_path, params: params }

      let(:params) { { patient_id: patient.id, page: 1, canceled: 1 } }

      it 'can show first page of orders with canceled' do
        expect(assigns[:orders]).to eq(patient.orders.page(params[:page]))
      end
    end

    context 'when params: canceled not specified' do
      before { get ajax_orders_path, params: params }

      let(:params) { { patient_id: patient.id, page: 1, canceled: 0 } }

      it 'can show first page of orders without canceled' do
        expect(assigns[:orders]).to eq(patient.orders_only_active.page(params[:page]))
      end
    end
  end

  describe 'GET /ajax/orders/edit/:id' do
    context 'when order was created by machine(not employee)' do
      before { get edit_ajax_order_path(order.id) }

      it 'can show "Unknown-Employee" as who is set current state of order' do
        expect(assigns[:originator]).to eq('Unknown-Employee')
      end

      it { should render_template('edit') }
    end

    context 'when order was updated by employee' do
      let(:valid_params) do
        { order: { canceled: true } }
      end

      before do
        put order_path(order.id), params: valid_params
        get edit_ajax_order_path(order.id)
      end

      with_versioning do
        it "can show employee's name that is set current state of order" do
          expect(assigns[:originator]).to eq(employee.fullname)
        end

        it { should render_template('edit') }
      end
    end
  end
end
