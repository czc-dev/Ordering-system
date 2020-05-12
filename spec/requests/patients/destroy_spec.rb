# frozen_string_literal: true

RSpec.describe 'Patient DELETE /patients/:id', type: :request, js: true do
  let(:patient) { create(:patient) }

  include_context :act_login_as_employee

  subject { delete patient_path(patient.id) }

  it 'deletes(discards) patient' do
    subject
    expect(Patient.with_discarded.find_by(id: patient.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    subject
    expect(Patient.find_by(id: patient.id)).to be_nil
  end

  it 'also deletes(discards) releated orders' do
    patient.orders.each do |order|
      expect(order.discarded?).to be_truthy
    end
  end

  it 'also deletes(discards) releated inspections' do
    patient.orders.each do |order|
      order.inspections.each do |inspection|
        expect(inspection.discarded?).to be_truthy
      end
    end
  end

  it { is_expected.to redirect_to(patients_url) }
end
