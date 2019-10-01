# frozen_string_literal: true

class Ajax::SelectExamSetsController < ApplicationController
  def new
    @exam_sets = ExamSet.where(id: params[:exam_set_ids])
    @resource_field = params[:resource_field]
    render layout: false
  end
end
