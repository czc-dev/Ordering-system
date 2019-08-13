# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Patient GET /patients/:id/edit', type: :request, js: true do
  let!(:patients) { create_list(:patient, 5) }
  let(:patient) { patients.first }
  let(:patient_id) { patient.id }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  context 'when patient exists' do
    before { get edit_patient_path(patient_id) }

    it 'can show specified patient\'s details in form' do
      expect(Patient.find(patient_id)).to eq(assigns[:patient])
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
