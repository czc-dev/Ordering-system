# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees GET /employees/new', type: :request, js: true do
  # WARNING: it rarely generates duplicated username by Faker::Internet.username
  let!(:administor) { create(:administor) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # all actions are requied logged in
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get new_employee_path }

  it { should render_template('new') }
end
