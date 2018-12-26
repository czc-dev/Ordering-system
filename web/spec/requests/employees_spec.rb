require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  # WARNING: it rarely generates duplicated username by Faker::Internet.username
  let!(:administor) { create(:administor) }
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # all actions are requied logged in
  before { post login_path, params: { username: administor.username, password: administor.password } }

  describe 'GET /employees' do
    before { get employees_path }

    it 'can show all employees' do
      expect(Employee.all).to eq(assigns[:employees])
    end
  end

  describe 'POST /employees' do
    context 'when request is valid' do
      let(:valid_params) do
        {
          employee: {
            fullname: 'Dr. Blah',
            username: 'blah',
            password: 'passworld',
            password_confirmation: 'passworld'
          }
        }
      end
      before { post employees_path, params: valid_params }

      it 'creates new employee' do
        expect(Employee.last).to eq(assigns[:employee])
      end

      it { should redirect_to(employee_path(Employee.last.id)) }
    end

    context 'when request is invalid' do
      let(:invalid_params) do
        {
          employee: {
            fullname: '',
            username: '',
            password: '',
            password_confirmation: ''
          }
        }
      end
      before { post employees_path, params: invalid_params }

      it { should render_template('new') }
    end

    # duplicates on model spec...?
    context 'when request\'s username has contain invalid format' do
      let(:base_params) do
        {
          employee: {
            fullname: 'Full Name',
            username: 'username',
            password: 'pa55word',
            password_confirmation: 'pa55word'
          }
        }
      end

      context 'which includes non-ASCII code' do
        before { post employees_path, params: base_params.merge(employee: { username: 'ユーザー名' }) }

        it { should render_template('new') }
      end

      context 'which is too short (length < 4)' do
        before { post employees_path, params: base_params.merge(employee: { username: 'usr' }) }

        it { should render_template('new') }
      end

      context 'which is too long (length > 64)' do
        before { post employees_path, params: base_params.merge(employee: { username: 'user' * 17 }) }

        it { should render_template('new') }
      end
    end
  end

  describe 'GET /employees/new' do
    before { get new_employee_path }

    it { should render_template('new') }
  end

  describe 'GET /employee/:id' do
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

  describe 'GET /employees/:id/edit' do
    context 'when employee exsits' do
      before { get edit_employee_path(employee_id) }

      it { should render_template('edit') }

      it 'can show specified employee' do
        expect(employee).to eq(assigns[:employee])
      end
    end

    context 'when employee does not exist' do
      before { get edit_employee_path(0) }

      it { should redirect_to(employees_path) }
    end
  end

  describe 'PATCH/PUT /employees/:id' do
    context 'when request is valid' do
      let(:valid_params) { { employee: { fullname: 'Dr. Update', password: 'employee' } } }
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

  describe 'DELETE /employees/:id' do
    pending 'data should not destroy'
  end
end
