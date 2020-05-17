# frozen_string_literal: true

RSpec.describe 'Employees PATCH/PUT /organizations/:organization_id/employees/:id', type: :request, js: true do
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  include_context :act_login_as_administrator

  subject { put employee_path(employee_id), params: params }

  context 'when request is valid' do
    let(:params) do
      {
        employee: {
          fullname: 'Dr. Update',
          username: 'dr_update',
          password: 'password'
        }
      }
    end

    it 'updates employee' do
      subject
      expect(employee.reload.fullname).to eq(params[:employee][:fullname])
    end

    it { is_expected.to redirect_to(employee_path(employee_id)) }
  end

  context 'when request with incorecct password' do
    let(:params) { { employee: { fullname: 'Dr.update', password: 'incorrect' } } }

    it { is_expected.to render_template('edit') }
  end
end
