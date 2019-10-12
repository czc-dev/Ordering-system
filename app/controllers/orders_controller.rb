# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_patient, only: %i[index new create]
  before_action :set_for_new, only: %i[new create]

  def index
    @page   = params[:page] || 1
    @orders = @patient.orders_only_active.page(params[:page])
  end

  def new; end

  def create
    if create_params[:exams].nil?
      flash.now[:warning] = '検査項目は必ず指定してください。'
      render :new, status: :bad_request
      return
    end

    @order = @patient.orders.create!(may_result_at: create_params[:may_result_at])
    create_params[:exams].each do |exam_item_id|
      @order.exams.create!(exam_item: ExamItem.find(exam_item_id))
    end

    flash[:success] = "オーダー##{@order.id}を作成しました。"
    CreateNotificationService.call(notification_type: :order_created, order: @order)
    redirect_to order_exams_path(@order)
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.update(update_params)

    flash[:success] = '更新しました。'
    CreateNotificationService.call(notification_type: :order_updated, order: @order)
    redirect_to patient_orders_path(@order.patient)
  end

  def destroy
    order = Order.find_by(id: params[:id])
    order.paper_trail_event = 'discard'
    order.discard
    flash[:success] = '該当オーダー情報を削除しました。'
    redirect_to patient_orders_url(order.patient.id)
  end

  private

  # 検査が1つも選択されなかった場合、再度 'new' アクションの描画を行う必要があります。
  #
  # 'render' メソッドは、 **同じアクション内で別のテンプレートを描画する** ため、
  # 'create' アクション内で「不正なフォーム送信」として再度 'render' した場合、
  # 検査の分類 (@set) と検査 (@details) が未定義となり、正しく動作しません
  # 'new, create' 両方のアクションにこれらの代入宣言を加えれば良いのですが、
  # DRYに反するということ、記述量の増加という点からメソッドとしてまとめ、
  # 'before_action' にフックしています。
  def set_for_new
    @order      = @patient.orders.new
    @exam_sets  = ExamSet.all
    @exam_items = ExamItem.all
  end

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id])
  end

  def create_params
    params.require(:order).permit(:may_result_at, exams: [])
  end

  def update_params
    params.require(:order).permit(:canceled, :may_result_at)
  end
end
