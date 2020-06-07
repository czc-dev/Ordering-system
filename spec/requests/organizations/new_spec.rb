RSpec.describe 'Organizations GET /organizations/new' do
  let(:invitation) { create(:invitation, :with_email) }

  subject { get new_organization_path, params: params }

  context 'when invitation_token is not set' do
    let(:params) { { invitation_token: '' } }

    it { is_expected.to redirect_to('/create') }
  end

  context 'when invitation_token is already expired' do
    let(:invitation) { create(:invitation, :with_email, :expired) }
    let(:params) { { invitation_token: invitation.token } }

    it { is_expected.to redirect_to('/create') }
  end

  context 'when invitation_token is set' do
    let(:params) { { invitation_token: invitation.token } }

    it { is_expected.to render_template('new') }
  end
end
