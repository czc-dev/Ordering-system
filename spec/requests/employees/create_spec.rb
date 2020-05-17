# frozen_string_literal: true

RSpec.describe 'Employees POST /employees', type: :request, js: true do
  subject { post organization_employees_path(organization), params: params }

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
      context 'when request params are invalid' do
        let(:params) do
          {
            invitation_token: invitation.token,
            employee: {
              fullname: '',
              email: '',
              password: '',
              password_confirmation: ''
            }
          }
        end

        it 'returns status code 400 (Bad request)' do
          subject
          expect(response).to have_http_status(400)
        end

        it { is_expected.to render_template('new') }

        it 'can find Invitation from query params (invitation_token)' do
          subject
          expect(assigns[:invitation]).not_to be_nil
        end
      end

      context 'when request params are valid' do
        let(:params) do
          {
            invitation_token: invitation.token,
            employee: {
              fullname: 'Dr. Blah',
              email: Faker::Internet.email,
              password: 'passworld',
              password_confirmation: 'passworld'
            }
          }
        end

        it 'creates new employee' do
          expect { subject }.to change { Employee.count }.by(1)
        end

        it { is_expected.to redirect_to(root_url) }

        it 'revokes used invitation token' do
          expect { subject }.to change { Invitation.discarded.count }.by(1)
        end
      end
    end
  end
end
