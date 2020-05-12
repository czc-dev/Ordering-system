# frozen_string_literal: true

RSpec.describe 'Assert redirection when GET any endpoints without logged in', type: :request, js: true do
  let(:employee_id) { create(:employee).id }
  let(:patient_id) { create(:patient).id }
  let(:order_id) { create(:order).id }
  let(:exam_id) { create(:exam).id }

  context 'GET /' do
    subject { get root_path }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /new/order' do
    subject { get new_order_path }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /employees' do
    subject { get employees_path }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /employees/new' do
    subject { get new_employee_path }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /employees/:id/edit' do
    subject { get edit_employee_path(employee_id) }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /patients' do
    subject { get patients_path }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /patients/new' do
    subject { get new_patient_path }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /patients/:id/edit' do
    subject { get edit_patient_path(patient_id) }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /patients/:patient_id/orders' do
    subject { get patient_orders_path(patient_id) }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /patients/:patient_id/orders/new' do
    subject { get new_patient_order_path(patient_id) }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /orders/:order_id/exams' do
    subject { get order_exams_path(order_id) }
    it { is_expected.to redirect_to(login_path) }
  end

  context 'GET /orders/:order_id/exams/new' do
    subject { get new_order_exam_path(order_id) }
    it { is_expected.to redirect_to(login_path) }
  end
end
