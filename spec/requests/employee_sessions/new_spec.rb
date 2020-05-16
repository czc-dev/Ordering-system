# frozen_string_literal: true

RSpec.describe 'EmployeeSessions GET /login', type: :request, js: true do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  subject { get login_path }
  it { is_expected.to render_template('new') }
end
