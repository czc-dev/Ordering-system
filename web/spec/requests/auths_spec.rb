require 'rails_helper'

RSpec.describe "Auths", type: :request do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  describe 'GET /login' do
    before { get login_path }
    it { should render_template('login') }
  end

  describe 'POST /login' do
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

      it { should render_template('login') }
    end
  end

  describe 'DELETE /logout' do
    context 'when employee is logged in' do
      before { delete logout_path }

      it { should redirect_to(root_path) }

      it 'removes session' do
        expect(session[:current_employee_id]).to be_empty
      end
    end

    context 'when employee is not logged in' do
      it { should redirect_to(login_path) }
    end
  end
end
