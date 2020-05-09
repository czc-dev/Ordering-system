# frozen_string_literal: true

RSpec.describe 'Auths POST /login', type: :request, js: true do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  context 'when request is valid' do
    let(:valid_employee) { { username: username, password: 'password' } }
    before { post login_path, params: valid_employee }

    it { should redirect_to(root_path) }

    it 'sets session :current_employee_id' do
      expect(session[:current_employee_id]).to eq(employee.id)
    end
  end

  context 'when request is invalid' do
    before { post login_path, params: {} }

    it { should render_template('new') }
  end
end
