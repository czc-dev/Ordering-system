# frozen_string_literal: true

RSpec.describe 'Auths POST /login', type: :request, js: true do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  context 'when request is valid' do
    let(:valid_employee) { { username: username, password: 'password' } }
    subject { post login_path, params: valid_employee }

    it { is_expected.to redirect_to(root_path) }

    it 'sets session :current_employee_id' do
      subject
      expect(session[:current_employee_id]).to eq(employee.id)
    end
  end

  context 'when request is invalid' do
    subject { post login_path, params: {} }

    it { is_expected.to render_template('new') }
  end
end
