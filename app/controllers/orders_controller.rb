# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_patient
  before_action :set_create_options, only: %i[new create]
  def index
    @orders = @patient.orders
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def new
  end

  # TODO: write concern for @order.save! and @order.inspections.create!
  def create
    p = new_order_params
    if p[:inspections].nil?
      flash.now[:warning] = '検査項目は必ず指定してください。'
      render :new
      return
    end

    @order.assign_attributes(may_result_at: p[:may_result_at])
    @order.save!

    # inspections is array of inspection_detail's id(string)
    p[:inspections].each do |id|
      @order.inspections.create!(
        inspection_detail: InspectionDetail.find_by(id: id)
      )
    end

    flash[:success] = 'オーダーを作成しました。'
    redirect_to patient_orders_path(@patient)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_create_options
    @order = @patient.orders.new
    @details = InspectionDetail.all
  end

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id])
  end

  def new_order_params
    params.require(:order).permit(:may_result_at, inspections: [])
  end
end
