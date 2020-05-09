# frozen_string_literal: true

RSpec.describe 'Employees PATCH/PUT /employees/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:employee, :administrator) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

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
