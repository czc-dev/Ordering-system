# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Exams GET /orders/:order_id/exams', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:exam) { order.exams.first }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get "/orders/#{order.id}/exams" }

  it "can show order's exams exclude canceled one" do
    expect(order.exams_only_active).to eq(assigns[:exams])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
