# frozen_string_literal: true

RSpec.describe 'Patient GET /patients/new', type: :request, js: true do
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  before { get new_patient_path }

  it 'assigns new Patient\'s instance' do
    expect(assigns[:patient].new_record?).to be_truthy
  end

  it { should render_template('new') }
end
