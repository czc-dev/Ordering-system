class Ajax::SelectingInspectionsController < ApplicationController
  def new
    @details = InspectionDetail.where(id: params[:detail_ids])
    render layout: false
  end
end
