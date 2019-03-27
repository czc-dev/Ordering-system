class Ajax::InspectionDetailsController < ApplicationController
  def index
    @details =
      if params[:set_id].blank?
        InspectionDetail.all
      else
        InspectionSet.find_by(id: params[:set_id]).inspection_details
      end
    render layout: false
  end
end
