# frozen_string_literal: true

RSpec.describe 'Orders GET /orders', type: :request, js: true do
  let(:order) { create_list(:order, 10) }
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
