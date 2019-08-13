# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees GET /employee/:id', type: :request, js: true do
  # WARNING: it rarely generates duplicated username by Faker::Internet.username
  let!(:administor) { create(:administor) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # all actions are requied logged in
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when employee exsits' do
    before { get employee_path(employee_id) }

    it 'can show specified employee' do
      expect(employee).to eq(assigns[:employee])
    end
  end

  context 'when employee does not exist' do
    before { get employee_path(0) }

    it { should redirect_to(employees_path) }
  end
end
