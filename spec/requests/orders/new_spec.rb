# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders GET /patients/:patient_id/orders/new', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get "/patients/#{patient.id}/orders/new" }

  it 'can show all InspectionSet' do
    # TODO: InspectionSetはテストにおいて空なので、定義する
    expect(InspectionSet.all).to eq(assigns[:sets])
  end

  it 'can show all InspectionDetail' do
    expect(InspectionDetail.all).to eq(assigns[:details])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
