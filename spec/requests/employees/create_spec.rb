# frozen_string_literal: true

RSpec.describe 'Employees POST /employees', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  include_context :act_login_as_administrator

  subject { post employees_path, params: params }

  context 'when request is valid' do
    let(:params) do
      {
        employee: {
          fullname: 'Dr. Blah',
          email: Faker::Internet.email,
          password: 'passworld',
          password_confirmation: 'passworld'
        }
      }
    end

    it 'creates new employee' do
      expect { subject }.to change { Employee.count }.by(1)
    end

    it { is_expected.to redirect_to(employee_path(Employee.last.id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      {
        employee: {
          fullname: '',
          email: '',
          password: '',
          password_confirmation: ''
        }
      }
    end

    it { is_expected.to render_template('new') }
  end
end
