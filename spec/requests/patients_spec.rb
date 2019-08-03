require 'rails_helper'

RSpec.describe 'Patient', type: :request, js: true do
  let!(:patients) { create_list(:patient, 5) }
  let(:patient) { patients.first }
  let(:patient_id) { patient.id }
  let(:employee) { create(:employee) }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /patients' do
    before { get '/patients' }

    it 'can show all patient' do
      expect(Patient.all).to eq(assigns[:patients])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /patients/new' do
    before { get new_patient_path }

    it 'assigns new Patient\'s instance' do
      expect(assigns[:patient].new_record?).to be_truthy
    end

    it { should render_template('new') }
  end

  describe 'POST /patients' do
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

  describe 'GET /patients/:id/edit' do
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

  describe 'PATCH/PUT /patients/:id/' do
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
      before { put patient_path(patient_id), params: valid_params }

      it 'updates patient' do
        p = Patient.find(patient_id)
        expect(p.birth.to_date).to eq(valid_params[:patient][:birth].to_date)
        expect(p.gender_id).to eq(valid_params[:patient][:gender_id])
        expect(p.name).to eq(valid_params[:patient][:name])
      end

      it 'can show created patient' do
        expect(patient).to eq(assigns[:patient])
      end

      it { should redirect_to(patient_orders_path(patient_id)) }
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
      before { put patient_path(patient_id), params: invalid_params }

      it 'shows "Fill in correctly" message' do
        expect(flash.now[:warning]).to eq('正しく入力してください。')
      end

      it { should render_template('edit') }
    end
  end

  describe 'DELETE /patients/:id' do
    pending 'data should not destroy'
  end
end
