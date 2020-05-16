RSpec.describe 'InitOrganizations POST /create' do
  subject { post '/create', params: params }

  context 'when posts email for administrator' do
    let(:params) { { email: Faker::Internet.email } }

    it 'creates invitation with email' do
      expect { subject }.to change { Invitation.count }.by(1)
    end

    it 'created invitation must have token' do
      subject
      invitation = Invitation.last
      expect(invitation.token).not_to be_nil
    end

    it 'created invitation must have posted email' do
      subject
      invitation = Invitation.last
      expect(invitation.email).to eq(params[:email])
    end
  end

  context 'when posts invalid format' do
    let(:params) { { email: 'invalid' } }

    it 'returns status code 400 (Bad Request)' do
      subject
      expect(response).to have_http_status(400)
    end

    it { is_expected.to render_template('new') }
  end
end
