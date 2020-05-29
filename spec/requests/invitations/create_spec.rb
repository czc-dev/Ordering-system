RSpec.describe 'Invitation POST /organizations/:organization_id/invitations', type: :request, js: true do
  let(:organization) { administrator.organization }

  include_context :act_login_as_administrator

  subject { post organization_invitations_path(organization), params: params }

  context 'when specifies expiration date' do
    let(:params) do
      {
        invitation: {
          expired_at: Faker::Date.forward(days: 30)
        }
      }
    end

    it 'creates invitation' do
      expect { subject }.to change { Invitation.count }.by(1)
    end

    it 'creates invitation with expiration date' do
      subject
      invitation = organization.invitations.last
      expect(invitation.expired_at).not_to be_nil
    end
  end

  context 'when does not specify expiration date' do
    let(:params) do
      { invitation: {} }
    end

    it 'creates invitation' do
      expect { subject }.to change { Invitation.count }.by(1)
    end

    it 'creates invitation without expiration date' do
      subject
      invitation = organization.invitations.last
      expect(invitation.expired_at).to be_nil
    end
  end
end
