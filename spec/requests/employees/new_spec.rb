# frozen_string_literal: true

RSpec.describe 'Employees GET /employees/new', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:administrator) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  before { get new_employee_path }

  it { should render_template('new') }
end
