require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  describe 'GET /employees' do
    it 'can show all employees' do
      expect(Employee.all).to eq(assigns[:employees])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /employees' do
    context 'when request is valid' do
      let(:valid_params) do
        {
          fullname: 'Dr. Blah',
          username: 'blah',
          password: 'passworld',
          password_confirmation: 'passworld'
        }
      end
      before { post employees_path, params: valid_params }

      it 'creates new employee' do
        expect(Employee.last).to eq(assigns[:employee])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post employees_path, params: {} }

      it { should set_flash.now[:warning].to('正しく入力してください。') }

      it 'returns status code 400(Bad request)' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /employees/new' do
    before { new_employee_path }

    it { should render_template('new') }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /employee/:id' do
    context 'when employee exsits' do
      before { get employee_path(employee_id) }

      it 'can show specified employee' do
        expect(employee).to eq(assigns[:employee])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when employee does not exist' do
      before { get employee_path(0) }

      it { should redirect_to(employees_path) }

      it { should set_flash.now[:warning].to('指定したデータは存在しません。') }
    end
  end

  describe 'GET /employees/:id/edit' do
    context 'when employee exsits' do
      before { get edit_employee_path(employee_id) }

      it { should render_template('edit') }

      it 'can show specified employee' do
        expect(employee).to eq(assigns[:employee])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when employee does not exist' do
      before { get edit_employee_path(0) }

      it { should redirect_to(employees_path) }

      it { should set_flash.now[:warning].to('指定したデータは存在しません。') }
    end
  end

  describe 'PATCH/PUT /employees/:id' do
    context 'when request is valid' do
      let(:valid_params) { { fullname: 'Dr. Update', password: 'employee' } }
      before { post employee_path(employee_id), params: valid_params }

      it 'updates employee' do
        expect(Employee.find(employee_id).fullname).to eq(valid_params[:fullname])
      end

      it { should render_template('show') }

      it { should set_flash.now[:success].to('従業員情報を更新しました。') }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request is invalid' do
      before { post employee_path(employee_id), params: {} }

      it { should render_template('edit') }

      it { should set_flash.now[:warning].to('正しく入力してください。') }
    end
  end

  describe 'DELETE /employees/:id' do
    pending 'data should not destroy'
  end
end
