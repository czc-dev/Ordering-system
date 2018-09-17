# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_patient, only: :index
  def index
    @orders = @patient.orders
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id])
  end
end
