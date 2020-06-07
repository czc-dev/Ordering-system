# frozen_string_literal: true

RSpec.describe 'Employees GET /organizations/:organization_id/employees/new', type: :request, js: true do
  subject { get new_organization_employee_path(organization), params: params }

  context 'case of after create organization' do
    # the difference between 'after created organization' and 'invite employee from link' on invitation
    # is that only does/doesn't contain email

    let(:invitation) { create(:invitation, :with_email, :with_organization) }
    let(:organization) { invitation.organization }

    it 'has relation to created organization' do
      expect(invitation.organization).not_to be_nil
    end

    it "has administrator's email on invitation" do
      expect(invitation.email).not_to be_nil
    end

    context 'when invitation_token is not set' do
      let(:params) { { invitation_token: '' } }

      it { is_expected.to redirect_to('/create') }
    end

    context 'when invitation_token is already expired' do
      let(:invitation) { create(:invitation, :with_email, :with_organization, :expired) }
      let(:params) { { invitation_token: invitation.token } }

      it { is_expected.to redirect_to('/create') }
    end

    context 'when invitation_token is set' do
      let(:params) { { invitation_token: invitation.token } }

      it { is_expected.to render_template('new') }
    end
  end
end
