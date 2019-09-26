# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Assert redirection when GET any endpoints without logged in', type: :request, js: true do
  let(:employee_id) { create(:employee).id }
  let(:patient_id) { create(:patient).id }
  let(:order_id) { create(:order).id }
  let(:exam_id) { create(:exam).id }

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

  context 'GET /orders/:order_id/exams' do
    before { get order_exams_path(order_id) }
    it { should redirect_to(login_path) }
  end

  context 'GET /orders/:order_id/exams/new' do
    before { get new_order_exam_path(order_id) }
    it { should redirect_to(login_path) }
  end
end
