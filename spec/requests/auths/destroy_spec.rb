# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auths DELETE /logout', type: :request, js: true do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  context 'when employee is logged in' do
    let(:valid_employee) { { username: username, password: 'password' } }
    before do
      post login_path, params: valid_employee
      get logout_path
    end

    it 'removes session' do
      expect(session[:current_employee_id]).to be_nil
    end

    it { should redirect_to(login_path) }
  end

  context 'when employee is not logged in' do
    before { get logout_path }
    it { should redirect_to(login_path) }
  end
end
