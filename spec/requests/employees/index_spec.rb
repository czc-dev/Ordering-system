# frozen_string_literal: true

RSpec.describe 'Employees GET /employees', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }
  let(:params) { { page: 1 } }

  include_context :act_login_as_administrator

  before { get employees_path, params: params }

  it 'can show all employees on first page' do
    expect(assigns[:employees]).to eq(Employee.page(params[:page]))
  end
end
