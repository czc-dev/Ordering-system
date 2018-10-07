# frozen_string_literal: true

class InspectionsController < ApplicationController
  before_action :set_order,   only: %i[index create new]
  before_action :set_for_new, only: %i[new create]

  def index
    @inspections =
      @order.inspections.includes(:inspection_detail, :sample, :result).where(canceled: false)
  end

  def show
    @inspection = Inspection.find_by(id: params[:id])
  end

  def new; end

  def create
    p = new_params
    if p[:inspections].nil?
      flash.now[:warning] = '検査項目は必ず指定してください。'
      render :new
      return
    end

    # inspections is array of inspection_detail's id(string)
    p[:inspections].each do |id|
      @order.inspections.create!(
        inspection_detail: InspectionDetail.find_by(id: id)
      )
    end

    flash[:success] = '検査項目を追加しました。'
    redirect_to order_inspections_path(@order)
  end

  def edit
    @inspection = Inspection.find_by(id: params[:id])
    @order = @inspection.order
  end

  def update
    @inspection = Inspection.find_by(id: params[:id])
    @inspection.update!(update_params)

    flash[:success] = '更新しました。'
    redirect_to order_inspections_url(@inspection.order)
  end

  def destroy; end

  private

  # `OrdersController#set_for_new`
  def set_for_new
    @inspection = @order.inspections.new
    @sets = InspectionSet.all
    @details = InspectionDetail.all
  end

  def set_order
    @order = Order.find_by(id: params[:order_id])
  end

  def new_params
    params.require(:order).permit(inspections: [])
  end

  def update_params
    params.require(:inspection).permit(:status_id, :urgent, :canceled)
  end
end
