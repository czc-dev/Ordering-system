# frozen_string_literal: true

class InspectionsController < ApplicationController
  before_action :set_order, only: %i[index create new]

  def index
    @inspections = @order.inspections
  end

  def show
    @inspection = Inspection.find_by(id: params[:id])
  end

  def edit
    @inspection = Inspection.find_by(id: params[:id])
    @order = @inspection.order
  end

  def create
  end

  def update
    @inspection = Inspection.find_by(id: params[:id])
    @inspection.update!(update_params)

    flash[:success] = '更新しました。'
    redirect_to order_inspections_url(@inspection.order)
  end

  def destroy
  end

  private

  def update_params
    params.require(:inspection).permit(:status_id, :urgent, :cancelled)
  end

  def set_order
    @order = Order.find_by(id: params[:order_id])
  end
end
