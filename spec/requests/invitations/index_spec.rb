RSpec.describe 'Invitation GET /organizations/:organization_id/invitations', type: :request, js: true do
  let(:organization) { administrator.organization }

  include_context :act_login_as_administrator

  before { create_list(:invitation, 10, organization: organization) }

  subject { get organization_invitations_path(organization) }

  it 'can show all invitations' do
    subject
    expect(assigns[:invitations]).to eq(organization.invitations)
  end

  it 'returns status code 200' do
    subject
    expect(response).to have_http_status(200)
  end
end
