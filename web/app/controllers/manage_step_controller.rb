# frozen_string_literal: true

class ManageStepController < ApplicationController
  def new_order
    @patients = Patient.all
  end

  def redirect_to_new_order
    redirect_to new_patient_order_url(params[:patient_id])
  end
end
