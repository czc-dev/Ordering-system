# frozen_string_literal: true

class AjaxController < ApplicationController
  # get all InspectionDetails from InspectionSet
  def details
    @details =
      if params[:set_id].blank?
        InspectionDetail.all
      else
        InspectionSet.find_by(id: params[:set_id]).inspection_details
      end
  end

  # pass selected_ids with formal_name to create <input type="hidden" value="?">
  # returns like [[3, "アルブミン"], [4, "チモール"]]
  def add_details
    @details =
      if params[:detail_ids].blank?
        []
      else
        data = InspectionDetail.where(id: params[:detail_ids])
        data.map { |d| [d.id, d.formal_name] }
      end
  end

  # show/hide orders if canceled or finished
  def patient_orders
    @patient = Patient.find_by(id: params[:patient_id])

    @orders =
      if params[:canceled].to_i.zero?
        @patient.orders.where(canceled: false)
      else
        @patient.orders
      end
  end

  # show/hide inspections if canceled
  def order_inspections
    @order = Order.find_by(id: params[:order_id])

    @inspections =
      if params[:canceled].to_i.zero?
        @order.inspections.includes(:inspection_detail, :sample, :result).where(canceled: false)
      else
        @order.inspections.includes(:inspection_detail, :sample, :result)
      end
  end
end
