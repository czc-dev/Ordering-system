# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees PATCH/PUT /employees/:id', type: :request, js: true do
  # WARNING: it rarely generates duplicated username by Faker::Internet.username
  let!(:administor) { create(:administor) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # all actions are requied logged in
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when request is valid' do
    let(:valid_params) { { employee: { fullname: 'Dr. Update', username: 'dr_update', password: 'password' } } }
    before { put employee_path(employee_id), params: valid_params }

    it 'updates employee' do
      expect(Employee.find(employee_id).fullname).to eq('Dr. Update')
    end

    it { should redirect_to(employee_path(employee_id)) }
  end

  context 'when request is invalid' do
    before { put employee_path(employee_id), params: { employee: { fullname: '' } } }

    it { should render_template('edit') }
  end
end
