# frozen_string_literal: true

class AjaxController < ApplicationController
  # get all InspectionDetails from InspectionSet
  def details
    return @details = InspectionDetail.all if params[:set_id].blank?
    @details = InspectionSet.find_by(id: params[:set_id]).inspection_details
  end

  # pass to selected_ids to create type="hidden" value="?"
  def add_details
    return @detail_ids = [] if params[:detail_ids].blank?
    @detail_ids = params[:detail_ids]
  end

  # show/hide inspections if canceled
  def order_inspections
    @order = Order.find_by(id: params[:order_id])
    return @inspections = @order.inspections unless params[:cancelled].to_i.zero?
    @inspections = @order.inspections.where(cancelled: false)
  end
end
