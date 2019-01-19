# frozen_string_literal: true

class InspectionsController < ApplicationController
  before_action :set_order,   only: %i[index create new]
  before_action :set_for_new, only: %i[new create]

  def index
    @inspections =
      @order.inspections.includes(:inspection_detail).where(canceled: false)
  end

  def new; end

  def create
    if create_params[:inspections].nil? || create_params[:inspections].include?('')
      flash.now[:warning] = '検査項目は必ず指定してください。'
      render :new, status: :bad_request
      return
    end

    CreateInspectionService.call(order: @order, inspections: create_params[:inspections])

    flash[:success] = '検査項目を追加しました。'
    CreateLogService.call(log_type: :inspection_added, resource: @order, employee: current_employee)
    CreateNotificationService.call(
      contents: {
        'en' => "Added inspections to Order##{@order.id}.",
        'ja' => "オーダー##{@order.id}に検査が追加されました。"
      },
      type: '検査の追加'
    )
    redirect_to order_inspections_path(@order)
  end

  def edit
    @inspection = Inspection.find_by(id: params[:id])
    @order = @inspection.order
    # for ajax magic
    respond_to do |format|
      format.html { render 'inspections/_edit_modal' }
      format.js
    end
  end

  def update
    @inspection = Inspection.find_by(id: params[:id])
    @inspection.update!(update_params)

    flash[:success] = '更新しました。'
    CreateLogService.call(log_type: :inspection_updated, resource: @inspection, employee: current_employee)
    CreateNotificationService.call(
      contents: {
        'en' => "Updated inspection of Order##{@inspection.order.id}.",
        'ja' => "オーダー##{@inspection.order.id}の検査が更新されました。"
      },
      type: '検査の更新'
    )
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

  def create_params
    params.require(:order).permit(inspections: [])
  end

  def update_params
    params
      .require(:inspection)
      .permit(:status_id, :urgent, :canceled, :sample, :result, :booked_at)
  end
end
