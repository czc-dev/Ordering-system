# frozen_string_literal: true

RSpec.describe 'Employees DELETE /employees/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  include_context :act_login_as_administrator

  subject { delete employee_path(employee.id) }

  it 'deletes(discards) employee' do
    subject
    expect(Employee.with_discarded.find_by(id: employee.id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    subject
    expect(Employee.find_by(id: employee.id)).to be_nil
  end

  it { is_expected.to redirect_to(login_url) }
end
