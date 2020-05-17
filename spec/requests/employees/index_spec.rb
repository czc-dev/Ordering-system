# frozen_string_literal: true

RSpec.describe 'Employees GET /organizations/:organization_id/employees', type: :request, js: true do
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }
  let(:params) { { page: 1 } }

  include_context :act_login_as_administrator

  subject { get organization_employees_path(administrator.organization), params: params }

  it 'can show all employees on first page' do
    subject
    expect(assigns[:employees]).to eq(Employee.page(params[:page]))
  end
end
