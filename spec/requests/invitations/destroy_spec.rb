RSpec.describe 'Invitation DELETE /invitations/:id', type: :request, js: true do
  let(:organization) { administrator.organization }
  let(:invitation) { create(:invitation) }

  include_context :act_login_as_administrator

  subject { delete invitation_path(invitation.id) }

  it 'REVOKES selected invitation' do
    # default_scope excludes revoked one
    expect { subject }.to change { Invitation.count }.by(-1)
  end

  it 'changes state to revoked' do
    subject
    expect(invitation.revoked?).to be_truthy
  end

  it { is_expected.to redirect_to(organization_invitations_url(organization)) }
end
