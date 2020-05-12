# frozen_string_literal: true

RSpec.describe 'Patient PATCH/PUT /patients/:id/', type: :request, js: true do
  let(:patient) { create(:patient) }

  include_context :act_login_as_employee

  subject { put patient_path(patient.id), params: params }

  context 'when request is valid' do
    let(:params) do
      {
        patient: {
          birth: Faker::Date.birthday,
          gender_id: 2,
          name: 'Updated Name'
        }
      }
    end

    it 'updates patient' do
      subject

      patient.reload
      expect(patient.birth.to_date).to eq(params[:patient][:birth].to_date)
      expect(patient.gender_id).to eq(params[:patient][:gender_id])
      expect(patient.name).to eq(params[:patient][:name])
    end

    it 'can show created patient' do
      subject
      expect(assigns[:patient]).to eq(patient.reload)
    end

    it { is_expected.to redirect_to(patient_orders_path(patient.id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      {
        patient: {
          birth: '',
          gender_id: '',
          name: ''
        }
      }
    end

    it 'shows "Fill in correctly" message' do
      subject
      expect(flash.now[:warning]).to eq('正しく入力してください。')
    end

    it { is_expected.to render_template('edit') }
  end
end
