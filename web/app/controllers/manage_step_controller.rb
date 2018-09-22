class ManageStepController < ApplicationController
  def new_order
    @patients = Patient.all
  end

  def redirect_to_new_order
    redirect_to new_patient_order_url(params[:patient_id])
  end

  def edit_order
  end

  def new_inspection
  end

  def edit_inspection
  end
end
