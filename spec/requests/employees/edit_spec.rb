# frozen_string_literal: true

RSpec.describe 'Employees GET /employees/:id/edit', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }

  include_context :act_login_as_administrator

  subject { get edit_employee_path(employee_id) }

  context 'when employee exsits' do
    let(:employee_id) { employee.id }

    it { is_expected.to render_template('edit') }

    it 'can show specified employee' do
      subject
      expect(employee).to eq(assigns[:employee])
    end
  end

  context 'when employee does not exist' do
    let(:employee_id) { 0 }

    it { is_expected.to redirect_to(employees_path) }
  end
end
