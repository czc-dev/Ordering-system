RSpec.describe do
  let(:invitation) { create(:invitation) }

  subject { post organizations_path, params: params }

  context 'when invitation_token is not set' do
    let(:params) do
      {
        organization: { name: Faker::Team.name },
        invitation_token: ''
      }
    end

    it { is_expected.to redirect_to('/create') }
  end

  context 'when invitation_token is set' do
    context 'when request params is incorrect' do
      let(:params) do
        {
          organization: { name: '' },
          invitation_token: invitation.token
        }
      end

      it 'returns status code 400(Bad request)' do
        subject
        expect(response).to have_http_status(400)
      end

      it { is_expected.to render_template('new') }

      it 'can read invitation_token from query params' do
        subject
        expect(assigns[:invitation_token]).not_to be_nil
      end
    end

    context 'when request params is correct' do
      let(:params) do
        {
          organization: { name: Faker::Team.name },
          invitation_token: invitation.token
        }
      end

      it { is_expected.to redirect_to(new_organization_employee_path(Organization.last)) }

      it 'creates new organization' do
        expect { subject }.to change { Organization.count }.by(1)
      end
    end
  end
end
