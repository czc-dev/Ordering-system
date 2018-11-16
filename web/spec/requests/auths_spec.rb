require 'rails_helper'

RSpec.describe "Auths", type: :request do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  describe 'GET /login' do
    before { get login_path }
    it { should render_template('login') }
  end

  describe 'POST /login' do
    context 'when request is valid' do
      let(:valid_employee) { { username: username, password: 'password' } }
      before { post login_path, params: valid_employee }

      it { should redirect_to(root_path) }

      it 'sets session :current_employee_id' do
        expect(session[:current_employee_id]).to eq(employee.id)
      end
    end

    context 'when request is invalid' do
      before { post login_path, params: {} }

      it { should render_template('login') }
    end
  end

  describe 'DELETE /logout' do
    context 'when employee is logged in' do
      let(:valid_employee) { { username: username, password: 'password' } }
      before do
        post login_path, params: valid_employee
        delete logout_path
      end

      it 'removes session' do
        expect(session[:current_employee_id]).to be_nil
      end

      it { should redirect_to(root_path) }
    end

    context 'when employee is not logged in' do
      before { delete logout_path }
      it { should redirect_to(login_path) }
    end
  end

  describe 'GET any endpoints without logged in' do
    let(:employee_id) { create(:employee).id }
    let(:patient_id) { create(:patient).id }
    let(:order_id) { create(:order).id }
    let(:inspection_id) { create(:inspection).id }

    context 'GET /' do
      before { get root_path }
      it { should redirect_to(login_path) }
    end

    context 'GET /new/order' do
      before { get new_order_path }
      it { should redirect_to(login_path) }
    end

    context 'GET /employees' do
      before { get employees_path }
      it { should redirect_to(login_path) }
    end

    context 'GET /employees/new' do
      before { get new_employee_path }
      it { should redirect_to(login_path) }
    end

    context 'GET /employees/:id/edit' do
      before { get edit_employee_path(employee_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /patients' do
      before { get patients_path }
      it { should redirect_to(login_path) }
    end

    context 'GET /patients/new' do
      before { get new_patient_path }
      it { should redirect_to(login_path) }
    end

    context 'GET /patients/:id/edit' do
      before { get edit_patient_path(patient_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /patients/:patient_id/orders' do
      before { get patient_orders_path(patient_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /patients/:patient_id/orders/new' do
      before { get new_patient_order_path(patient_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /orders/:id/edit' do
      before { get edit_order_path(order_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /orders/:order_id/inspections' do
      before { get order_inspections_path(order_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /orders/:order_id/inspections/new' do
      before { get new_order_inspection_path(order_id) }
      it { should redirect_to(login_path) }
    end

    context 'GET /inspections/:id/edit' do
      before { get edit_inspection_path(inspection_id) }
      it { should redirect_to(login_path) }
    end
  end
end
