# frozen_string_literal: true

class AjaxController < ApplicationController
  # get all InspectionDetails from InspectionSet
  def details
    return @details = InspectionDetail.all if params[:set_id].blank?
    @details = InspectionSet.find_by(id: params[:set_id]).inspection_details
  end

  # pass selected_ids with formal_name to create <input type="hidden" value="?">
  # returns like [[3, "アルブミン"], [4, "チモール"]]
  def add_details
    return @details = [] if params[:detail_ids].blank?
    details = InspectionDetail.where(id: params[:detail_ids])
    @details = details.map { |d| [d.id, d.formal_name] }
  end

  # show/hide orders if canceled or finished
  def patient_orders
    @patient = Patient.find_by(id: params[:patient_id])
    return @orders = @patient.orders unless params[:canceled].to_i.zero?
    @orders = @patient.orders.where(canceled: false)
  end

  # show/hide inspections if canceled
  def order_inspections
    @order = Order.find_by(id: params[:order_id])
    return @inspections = @order.inspections unless params[:canceled].to_i.zero?
    @inspections = @order.inspections.where(canceled: false)
  end
end
