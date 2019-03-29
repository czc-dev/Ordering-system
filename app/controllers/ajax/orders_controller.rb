class Ajax::OrdersController < ApplicationController
  def index
    @patient = Patient.find_by(id: params[:patient_id])

    @orders =
      if params[:canceled].to_i.zero?
        @patient.orders_only_active
      else
        @patient.orders
      end
    render layout: false
  end

  def edit
  end
end
