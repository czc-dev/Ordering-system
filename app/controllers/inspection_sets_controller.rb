# frozen_string_literal: true

class InspectionSetsController < ApplicationController
  def index
    @inspection_sets = InspectionSet.all
  end

  def new
    @inspection_set = InspectionSet.new
    @inspection_details = InspectionDetail.all
  end

  def create
    @inspection_set = InspectionSet.new(inspection_set_params)
    if @inspection_set.save
      redirect_to inspection_set_path(@inspection_set)
    else
      render :new, status: :bad_request
    end
  end

  def show
    @inspection_set = InspectionSet.find_by(id: params[:id])
  end

  def edit
    @inspection_set = InspectionSet.find_by(id: params[:id])
    @inspection_details = InspectionDetail.all
  end

  def update
    @inspection_set = InspectionSet.find_by(id: params[:id])
    if @inspection_set.update(inspection_set_params)
      redirect_to inspection_set_path(@inspection_set)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    inspection_set = InspectionSet.find_by(id: params[:id])
    inspection_set.paper_trail_event = 'discard'
    inspection_set.discard
    flash[:success] = '検査セット情報を削除しました。'
    redirect_to inspection_sets_path
  end

  private

  def inspection_set_params
    params
      .require(:inspection_set)
      .permit(:set_name, inspection_details: [])
      .yield_self do |p|
        # 検査詳細IDの集合を InspectionDetail オブジェクトの集合(ActiveRecord::Relation)へ変換して返す
        p.merge(
          inspection_details:
            InspectionDetail.where(id: p[:inspection_details]).limit(p[:inspection_details]&.size)
        )
      end
  end
end
