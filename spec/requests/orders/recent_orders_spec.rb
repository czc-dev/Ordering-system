# frozen_string_literal: true

RSpec.describe 'Orders GET /orders', type: :request, js: true do
  let(:order) { create_list(:order, 10) }

  include_context :act_login_as_employee

  subject { get recent_orders_path }

  it 'can show 20 orders which is created recently' do
    subject
    expect(assigns[:orders]).to eq(Order.recently_created)
  end

  it 'returns status code 200' do
    subject
    expect(response).to have_http_status(200)
  end
end
