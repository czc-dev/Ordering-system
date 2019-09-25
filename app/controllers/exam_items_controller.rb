# frozen_string_literal: true

class ExamItemsController < ApplicationController
  def index
    @exam_items = ExamItem.all
  end

  def new
    @exam_item = ExamItem.new
    @exam_sets = ExamSet.all
  end

  def create
    @exam_item = ExamItem.new(exam_item_params)
    if @exam_item.save
      redirect_to exam_item_path(@exam_item)
    else
      render :new, status: :bad_request
    end
  end

  def show
    @exam_item = ExamItem.find_by(id: params[:id])
  end

  def edit
    @exam_item = ExamItem.find_by(id: params[:id])
    @exam_sets = ExamSet.all
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
      .permit(:formal_name, :abbreviation, exam_sets: [])
      .yield_self do |p|
        # 検査セットIDの集合を InspetionSet オブジェクトの集合(ActiveRecord::Relation)へ変換して返す
        p.merge(
          exam_sets:
            ExamSet.where(id: p[:exam_sets]).limit(p[:exam_sets]&.size)
        )
      end
  end
end
