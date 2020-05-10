# frozen_string_literal: true

RSpec.describe 'Patient PATCH/PUT /patients/:id/', type: :request, js: true do
  let(:patient) { create(:patient) }

  include_context :act_login_as_employee

  context 'when request is valid' do
    let(:valid_params) do
      {
        patient: {
          birth: Faker::Date.birthday,
          gender_id: 2,
          name: 'Updated Name'
        }
      }
    end
    before { put patient_path(patient.id), params: valid_params }

    it 'updates patient' do
      p = Patient.find(patient.id)
      expect(p.birth.to_date).to eq(valid_params[:patient][:birth].to_date)
      expect(p.gender_id).to eq(valid_params[:patient][:gender_id])
      expect(p.name).to eq(valid_params[:patient][:name])
    end

    it 'can show created patient' do
      expect(patient).to eq(assigns[:patient])
    end

    it { should redirect_to(patient_orders_path(patient.id)) }
  end

  context 'when request is invalid' do
    let(:invalid_params) do
      {
        patient: {
          birth: '',
          gender_id: '',
          name: ''
        }
      }
    end
    before { put patient_path(patient.id), params: invalid_params }

    it 'shows "Fill in correctly" message' do
      expect(flash.now[:warning]).to eq('正しく入力してください。')
    end

    it { should render_template('edit') }
  end
end
