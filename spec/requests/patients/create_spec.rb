# frozen_string_literal: true

RSpec.describe 'Patient POST /patients', type: :request, js: true do
  let!(:patients) { create_list(:patient, 5) }
  let(:patient) { patients.first }
  let(:patient_id) { patient.id }
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  context 'when request is valid' do
    let(:valid_params) do
      {
        patient: {
          birth: Faker::Date.birthday,
          gender_id: 1,
          name: Gimei.kanji
        }
      }
    end
    before { post patients_path, params: valid_params }

    it 'creates new patient' do
      p = Patient.last
      expect(p.birth.to_date).to eq(valid_params[:patient][:birth].to_date)
      expect(p.gender_id).to eq(valid_params[:patient][:gender_id])
      expect(p.name).to eq(valid_params[:patient][:name])
    end

    it 'can show created patient' do
      expect(Patient.last).to eq(assigns[:patient])
    end

    it { should redirect_to(patient_orders_path(Patient.last.id)) }
  end

  context 'when request is invalid' do
    before { post patients_path, params: { patient: { empty: '' } } }

    it 'shows "Fill in correctly" message' do
      expect(flash.now[:warning]).to eq('正しく入力してください。')
    end

    it { should render_template('new') }
  end
end
