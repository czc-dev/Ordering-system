class Ajax::InspectionsController < ApplicationController
  def index
    @order = Order.find_by(id: params[:order_id])

    @inspections =
      if params[:canceled].to_i.zero?
        @order.inspections_only_active
      else
        @order.inspections_with_detail
      end
    render layout: false
  end

  def edit
  end
end
