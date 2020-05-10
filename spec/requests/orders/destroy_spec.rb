# frozen_string_literal: true

RSpec.describe 'Orders DELETE /orders/:id', type: :request, js: true do
  let(:order) { create(:order) }

  include_context :act_login_as_employee

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
