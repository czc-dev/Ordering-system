# frozen_string_literal: true

class Ajax::SelectExamItemsController < ApplicationController
  def index
    @exam_items =
      if params[:exam_set_id].blank?
        ExamItem.all
      else
        ExamSet.find_by(id: params[:exam_set_id]).exam_items
      end
    render layout: false
  end

  def new
    @exam_items = ExamItem.where(id: params[:exam_item_ids])
    render layout: false
  end
end
