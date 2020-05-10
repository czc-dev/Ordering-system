# frozen_string_literal: true

RSpec.describe 'Employees GET /employee/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  include_context :act_login_as_administrator

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
