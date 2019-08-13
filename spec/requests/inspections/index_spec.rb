# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inspections GET /orders/:order_id/inspections', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:inspection) { order.inspections.first }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get "/orders/#{order.id}/inspections" }

  it "can show order's inspections exclude canceled one" do
    expect(order.inspections_only_active).to eq(assigns[:inspections])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
