# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders DELETE /orders/:id', type: :request, js: true do
  # モックとして作成される各患者は
  # 10個の検査からなる1つのオーダーを持ちます
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { delete order_path(order.id) }

  it 'deletes(discards) order' do
    expect(Order.with_discarded.find_by(id: order.id).discarded?).to be_truthy
  end

  it 'also deletes(discards) releated exams' do
    order.exams.each do |exam|
      expect(exam.discarded?).to be_truthy
    end
  end

  it 'cannot find by any resource because default_scope is set' do
    expect(Order.find_by(id: order.id)).to be_nil
  end

  it { should redirect_to(patient_orders_url(order.patient.id)) }
end
