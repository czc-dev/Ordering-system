# frozen_string_literal: true

RSpec.describe 'Orders PATCH/PUT /orders/:id/', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

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
