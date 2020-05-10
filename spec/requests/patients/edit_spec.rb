# frozen_string_literal: true

RSpec.describe 'Patient GET /patients/:id/edit', type: :request, js: true do
  let(:patient) { create(:patient) }

  include_context :act_login_as_employee

  context 'when patient exists' do
    before { get edit_patient_path(patient.id) }

    it 'can show specified patient\'s details in form' do
      expect(Patient.find(patient.id)).to eq(assigns[:patient])
    end

    it { should render_template('edit') }
  end

  context 'when patient does not exist' do
    let(:patient_id) { 0 }
    before { get edit_patient_path(patient_id) }

    it 'can show "Not found" flash message' do
      expect(flash[:warning]).to eq('該当患者は存在しません。不正なリクエストです。')
    end

    it { should redirect_to(patients_path) }
  end
end
