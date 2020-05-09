# frozen_string_literal: true

RSpec.describe 'Orders GET /orders', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get recent_orders_path }

  it 'can show 20 orders which is created recently' do
    expect(assigns[:orders]).to eq(Order.lists_recently_created)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
