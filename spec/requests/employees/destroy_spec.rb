# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees DELETE /employees/:id', type: :request, js: true do
  # WARNING: it rarely generates duplicated username by Faker::Internet.username
  let!(:administor) { create(:administor) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # all actions are requied logged in
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { delete employee_path(employee.id) }

  it 'deletes(discards) employee' do
    expect(Employee.with_discarded.find_by(id: employee.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    expect(Employee.find_by(id: employee.id)).to be_nil
  end

  it 'should remove current session' do
    expect(session[:current_employee_id]).to be_nil
  end

  it { should redirect_to(login_url) }
end
