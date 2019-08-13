# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees GET /employees', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get employees_path }

  it 'can show all employees' do
    expect(Employee.all).to eq(assigns[:employees])
  end
end
