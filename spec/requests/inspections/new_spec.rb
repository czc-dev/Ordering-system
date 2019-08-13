# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inspections GET /orders/:order_id/inspections/new', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:inspection) { order.inspections.first }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get new_order_inspection_path(order.id) }

  it 'can show all InspectionSet' do
    # TODO: define InspectionSet; Current is nil
    expect(InspectionSet.all).to eq(assigns[:sets])
  end

  it 'can show all InspectionDetail' do
    expect(InspectionDetail.all).to eq(assigns[:details])
  end

  it { should render_template('new') }
end
