# frozen_string_literal: true

class AjaxController < ApplicationController
  # get all InspectionDetails from InspectionSet
  def details
    return @details = InspectionDetail.all if params[:set_id].blank?
    @details = InspectionSet.find_by(id: params[:set_id]).inspection_details
  end

  # pass to selected_ids to create type="hidden" value="?"
  # returns like [[3, "アルブミン"], [4, "チモール"]]
  def add_details
    return @details = [] if params[:detail_ids].blank?
    details = InspectionDetail.where(id: params[:detail_ids])
    @details = details.map { |d| [d.id, d.formal_name] }
  end

  # show/hide inspections if canceled
  def order_inspections
    @order = Order.find_by(id: params[:order_id])
    return @inspections = @order.inspections unless params[:cancelled].to_i.zero?
    @inspections = @order.inspections.where(cancelled: false)
  end
end
