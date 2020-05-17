# frozen_string_literal: true

RSpec.describe 'Employees GET /employees/new', type: :request, js: true do
  subject { get new_organization_employee_path(organization), params: params }

  context 'case of after create organization' do
    let(:invitation) { create(:invitation, :with_email) }
    let(:organization) { invitation.organization }

    before do
      before_params = {
        invitation_token: invitation.token,
        organization: { name: Faker::Team.name }
      }
      post organizations_path, params: before_params
      invitation.reload
    end

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

    context 'when invitation_token is set' do
      let(:params) { { invitation_token: invitation.token } }

      it { is_expected.to render_template('new') }
    end
  end
end
