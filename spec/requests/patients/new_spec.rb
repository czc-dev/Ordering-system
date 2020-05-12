# frozen_string_literal: true

RSpec.describe 'Patient GET /patients/new', type: :request, js: true do
  include_context :act_login_as_employee

  subject { get new_patient_path }

  it 'assigns new Patient\'s instance' do
    subject
    expect(assigns[:patient].new_record?).to be_truthy
  end

  it { is_expected.to render_template('new') }
end
