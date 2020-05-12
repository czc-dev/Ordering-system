# frozen_string_literal: true

RSpec.describe 'Orders DELETE /orders/:id', type: :request, js: true do
  let(:order) { create(:order) }

  include_context :act_login_as_employee

  subject { delete order_path(order.id) }

  it 'deletes(discards) order' do
    subject
    expect(Order.with_discarded.find_by(id: order.id).discarded?).to be_truthy
  end

  it 'also deletes(discards) releated exams' do
    subject
    order.exams.each do |exam|
      expect(exam.discarded?).to be_truthy
    end
  end

  it 'cannot find by any resource because default_scope is set' do
    subject
    expect(Order.find_by(id: order.id)).to be_nil
  end

  it { is_expected.to redirect_to(patient_orders_url(order.patient.id)) }
end
