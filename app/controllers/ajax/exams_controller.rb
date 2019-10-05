# frozen_string_literal: true

class Ajax::ExamsController < ApplicationController
  def index
    @order = Order.find_by(id: params[:order_id])

    @exams =
      if params[:canceled].to_i.zero?
        @order.exams_only_active
      else
        @order.exams_with_detail
      end
    render layout: false
  end

  def edit
    @exam = Exam.find_by(id: params[:id])
    @originator = Employee.originator_of(@exam)
    render layout: false
  end
end
