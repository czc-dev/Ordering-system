# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders POST /patients/:patient_id/orders', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

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
