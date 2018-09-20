# frozen_string_literal: true

class AjaxController < ApplicationController
  # get all InspectionDetails from InspectionSet
  def details
    return @details = InspectionDetail.all if params[:set_id].blank?
    @details = InspectionSet.find_by(id: params[:set_id]).inspection_details
  end

  def add_details
    return @detail_ids = [] if params[:detail_ids].blank?
    @detail_ids = params[:detail_ids]
  end
end
