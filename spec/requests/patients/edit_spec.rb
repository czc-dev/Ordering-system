# frozen_string_literal: true

RSpec.describe 'Patient GET /patients/:id/edit', type: :request, js: true do
  let(:patient) { create(:patient) }

  include_context :act_login_as_employee

  subject { get edit_patient_path(patient_id) }

  context 'when patient exists' do
    let(:patient_id) { patient.id }

    it 'can show specified patient\'s details in form' do
      subject
      expect(assigns[:patient]).to eq(Patient.find(patient_id))
    end

    it { is_expected.to render_template('edit') }
  end

  context 'when patient does not exist' do
    let(:patient_id) { 0 }

    it 'can show "Not found" flash message' do
      subject
      expect(flash[:warning]).to eq('該当患者は存在しません。不正なリクエストです。')
    end

    it { is_expected.to redirect_to(organization_patients_path(current_user.organization)) }
  end
end
