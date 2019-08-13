# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inspections DELETE /inspections/:id', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:inspection) { order.inspections.first }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { delete inspection_path(inspection.id) }

  it 'deletes(discards) inspection' do
    expect(Inspection.with_discarded.find_by(id: inspection.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    expect(Inspection.find_by(id: inspection.id)).to be_nil
  end

  it { should redirect_to(order_inspections_url(inspection.order.id)) }
end
