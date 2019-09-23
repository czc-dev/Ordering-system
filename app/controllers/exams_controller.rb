# frozen_string_literal: true

class ExamsController < ApplicationController
  before_action :set_order,   only: %i[index create new]
  before_action :set_for_new, only: %i[new create]

  def index
    @exams = @order.exams_only_active
  end

  def new; end

  # アクション名としては 'create' ですが、
  # 操作的には該当オーダーへの 'add' なので、注意してください
  def create
    if create_params[:exams].nil? || create_params[:exams].include?('')
      flash.now[:warning] = '検査項目は必ず指定してください。'
      render :new, status: :bad_request
      return
    end

    create_params[:exams].each do |inspection_detail_id|
      @order.exams.create!(inspection_detail: InspectionDetail.find(inspection_detail_id))
    end

    flash[:success] = '検査項目を追加しました。'
    CreateNotificationService.call(notification_type: :exam_added, order: @order)
    redirect_to order_exams_path(@order)
  end

  def update
    @exam = Exam.find_by(id: params[:id])
    @exam.update!(update_params)

    flash[:success] = '更新しました。'
    CreateNotificationService.call(notification_type: :exam_updated, order: @exam.order)
    redirect_to order_exams_url(@exam.order)
  end

  def destroy
    exam = Exam.find_by(id: params[:id])
    exam.paper_trail_event = 'discard'
    exam.discard
    flash[:success] = '該当検査情報を削除しました。'
    redirect_to order_exams_url(exam.order.id)
  end

  private

  # 詳細については `OrdersController#set_for_new` を参照してください。
  def set_for_new
    @exam = @order.exams.new
    @sets = InspectionSet.all
    @details = InspectionDetail.all
  end

  def set_order
    @order = Order.find_by(id: params[:order_id])
  end

  def create_params
    params.require(:order).permit(exams: [])
  end

  def update_params
    params
      .require(:exam)
      .permit(:status_id, :urgent, :canceled, :submitted, :sample, :result, :appraisal, :booked_at)
  end
end
