# frozen_string_literal: true

class ExamItemsController < ApplicationController
  before_action :set_exam_datas, only: %i[new create edit update]

  def index
    @exam_items = ExamItem.page(params[:page])
  end

  def new
    @exam_item = ExamItem.new
  end

  def create
    @exam_item = ExamItem.new(exam_item_params)
    if @exam_item.save
      flash[:success] = "検査詳細 #{@exam_item.formal_name} を作成しました。"
      redirect_to exam_items_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @exam_item = ExamItem.find_by(id: params[:id])
  end

  def update
    @exam_item = ExamItem.find_by(id: params[:id])
    if @exam_item.update(exam_item_params)
      redirect_to exam_item_path(@exam_item)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    exam_item = ExamItem.find_by(id: params[:id])
    exam_item.paper_trail_event = 'discard'
    exam_item.discard
    flash[:success] = '検査詳細情報を削除しました。'
    redirect_to exam_items_path
  end

  private

  def exam_item_params
    params
      .require(:exam_item)
      .permit(:formal_name, :abbreviation, exam_set_ids: [])
  end

  def set_exam_datas
    @exam_items = ExamItem.all
    @exam_sets  = ExamSet.all
  end
end
