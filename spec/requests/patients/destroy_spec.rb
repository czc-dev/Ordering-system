# frozen_string_literal: true

RSpec.describe 'Patient DELETE /patients/:id', type: :request, js: true do
  let(:patient) { create(:patient) }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { delete patient_path(patient.id) }

  it 'deletes(discards) patient' do
    expect(Patient.with_discarded.find_by(id: patient.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
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

  it { should redirect_to(patients_url) }
end
