# frozen_string_literal: true

RSpec.describe 'Orders PATCH/PUT /orders/:id/', type: :request, js: true do
  let(:order) { create(:order) }

  include_context :act_login_as_employee

  subject { put order_path(order.id), params: params }

  context 'when send request that cencel order' do
    let(:params) do
      { order: { canceled: true } }
    end

    it 'should cancel order' do
      subject
      expect(Order.find(order.id).canceled?).to be_truthy
    end

    it { is_expected.to redirect_to(patient_orders_path(order.patient.id)) }
  end
end
