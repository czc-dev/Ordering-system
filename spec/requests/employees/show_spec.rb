# frozen_string_literal: true

RSpec.describe 'Employees GET /organizations/:organization_id/employee/:id', type: :request, js: true do
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  include_context :act_login_as_administrator

  subject { get employee_path(employee_id) }

  context 'when employee exsits' do
    let(:employee_id) { employee.id }

    it 'can show specified employee' do
      subject
      expect(employee).to eq(assigns[:employee])
    end
  end

  context 'when employee does not exist' do
    let(:employee_id) { 0 }

    it { is_expected.to redirect_to(organization_employees_path(administrator.organization)) }
  end
end
