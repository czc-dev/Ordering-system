RSpec.describe 'InitOrganizations GET /create' do
  subject { get '/create' }

  it { is_expected.to render_template('new') }
end
