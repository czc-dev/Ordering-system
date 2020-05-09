# frozen_string_literal: true

RSpec.describe 'Orders POST /patients/:patient_id/orders', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  context 'when the request is valid' do
    let(:valid_params) do
      { order: { exam_item_ids: (1..10).to_a, may_result_at: Time.zone.now + 10.days } }
    end
    before { post patient_orders_path(patient.id), params: valid_params }

    it 'creates a order' do
      expect(assigns[:order]).to eq(Order.last)
    end

    it { should redirect_to(order_exams_path(Order.last)) }
  end

  context 'when no exams selected' do
    let(:invalid_params) do
      { order: { may_result_at: Time.zone.now + 10.days } }
    end
    before { post patient_orders_path(patient.id), params: invalid_params }

    it { should render_template('new') }

    it 'returns status code 400(Bad request)' do
      expect(response).to have_http_status(400)
    end
  end
end
