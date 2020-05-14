# frozen_string_literal: true

RSpec.describe 'Employees PATCH/PUT /employees/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
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
