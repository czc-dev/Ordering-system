# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders GET /patients/:patient_id/orders', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }
  let(:params) { { page: 1 } }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get "/patients/#{patient.id}/orders" }

  it "can show patient's orders exclude canceled one on first page" do
    expect(assigns[:orders]).to eq(patient.orders_only_active.page(params[:page]))
  end

  it 'should use variable "page" for making ajax request' do
    expect(assigns[:page]).to eq(params[:page])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
