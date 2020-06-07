# frozen_string_literal: true

RSpec.describe 'Patient POST /patients', type: :request, js: true do
  include_context :act_login_as_employee

  subject { post organization_patients_path(current_user.organization), params: params }

  context 'when request is valid' do
    let(:params) do
      {
        patient: {
          birth: Faker::Date.birthday,
          gender_id: 1,
          name: Gimei.kanji
        }
      }
    end

    it 'creates new patient' do
      expect { subject }.to change { Patient.count }.by(1)
    end

    it 'can show created patient' do
      subject
      expect(assigns[:patient]).to eq(Patient.last)
    end

    it { is_expected.to redirect_to(patient_orders_path(Patient.last.id)) }
  end

  context 'when request is invalid' do
    let(:params) { { patient: { name: '' } } }

    it 'shows "Fill in correctly" message' do
      subject
      expect(flash.now[:warning]).to eq('正しく入力してください。')
    end

    it { is_expected.to render_template('new') }
  end
end
