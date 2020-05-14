# frozen_string_literal: true

RSpec.describe 'EmployeeSessions POST /login', type: :request, js: true do
  let!(:employee) { create(:employee) }

  context 'when request is valid' do
    let(:valid_employee) { { email: employee.email, password: 'password' } }
    subject { post login_path, params: valid_employee }

    it { is_expected.to redirect_to(root_path) }
  end

  context 'when request is invalid' do
    subject { post login_path, params: {} }

    it { is_expected.to render_template('new') }
  end
end
