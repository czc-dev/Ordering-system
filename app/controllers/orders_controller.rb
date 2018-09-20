# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_patient, only: %i[index new create]
  before_action :set_for_new, only: %i[new create]

  def index
    @orders = @patient.orders
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def new
  end

  # TODO: write concern for @order.create! and @order.inspections.create!
  def create
    p = new_params
    if p[:inspections].nil?
      flash.now[:warning] = '検査項目は必ず指定してください。'
      render :new
      return
    end

    @order = @patient.orders.create!(may_result_at: p[:may_result_at])

    # inspections is array of inspection_detail's id(string)
    p[:inspections].each do |id|
      @order.inspections.create!(
        inspection_detail: InspectionDetail.find_by(id: id)
      )
    end

    flash[:success] = "オーダー##{@order.id}を作成しました。"
    redirect_to order_inspections_path(@order)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # if no inspections selected, must re-render 'new'
  # and set @order and @details
  # because `render` doesn't call as action(same request)
  def set_for_new
    @order = @patient.orders.new
    @sets  = InspectionSet.all
    @details = InspectionDetail.all
  end

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id])
  end

  def new_params
    params.require(:order).permit(:may_result_at, inspections: [])
  end
end
