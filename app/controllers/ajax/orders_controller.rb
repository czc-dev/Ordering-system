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
    @order = Order.find_by(id: params[:id])
    @originator = Employee.originator_of(@order)
    render layout: false
  end
end
