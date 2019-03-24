class ChoosePatientForNewOrdersController < ApplicationController
  def new
    @patients = Patient.all
  end

  def create
    redirect_to new_patient_order_url(params[:patient_id])
  end
end
