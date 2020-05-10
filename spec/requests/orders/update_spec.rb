# frozen_string_literal: true

RSpec.describe 'Orders PATCH/PUT /orders/:id/', type: :request, js: true do
  let(:order) { create(:order) }

  include_context :act_login_as_employee

  context 'when request is valid' do
    let(:valid_params) do
      { order: { canceled: true } }
    end
    before { put order_path(order.id), params: valid_params }

    it 'updates order' do
      expect(Order.find(order.id).canceled?).to be_truthy
    end

    it { should redirect_to(patient_orders_path(order.patient.id)) }
  end
end
