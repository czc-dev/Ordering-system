RSpec.describe 'Invitation GET /organizations/:organization_id/invitations/new', type: :request, js: true do
  let(:organization) { administrator.organization }

  include_context :act_login_as_administrator

  subject { get organization_invitations_path(organization) }

  it 'assigns new invitation' do
    subject
    expect(assigns[:invitation]).not_to be_nil
  end

  it 'returns status code 200' do
    subject
    expect(response).to have_http_status(200)
  end
end
