# frozen_string_literal: true

RSpec.describe 'EmployeeSessions DELETE /logout', type: :request, js: true do
  let!(:employee) { create(:employee) }

  context 'when employee is logged in' do
    let(:valid_employee) { { email: employee.email, password: 'password' } }
    subject do
      post login_path, params: valid_employee
      get logout_path
    end

    it { is_expected.to redirect_to(login_path) }
  end

  context 'when employee is not logged in' do
    subject { get logout_path }

    it { is_expected.to redirect_to(login_path) }
  end
end
