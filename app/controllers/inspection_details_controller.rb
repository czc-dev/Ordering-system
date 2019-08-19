class InspectionDetailsController < ApplicationController
  def index
    @inspection_details = InspectionDetail.all
  end

  def new
    @inspection_detail = InspectionDetail.new
    @inspection_sets   = InspectionSet.all
  end

  def create
    @inspection_detail = InspectionDetail.new(inspection_detail_params)
    if @inspection_detail.save
      redirect_to inspection_detail_path(@inspection_detail)
    else
      render :new, status: :bad_request
    end
  end

  def show
    @inspection_detail = InspectionDetail.find_by(id: params[:id])
  end

  def edit
    @inspection_detail = InspectionDetail.find_by(id: params[:id])
    @inspection_sets   = InspectionSet.all
  end

  def update
    @inspection_detail = InspectionDetail.find_by(id: params[:id])
    if @inspection_detail.update(inspection_detail_params)
      redirect_to inspection_detail_path(@inspection_detail)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    inspection_detail = InspectionDetail.find_by(id: params[:id])
    inspection_detail.paper_trail_event = 'discard'
    inspection_detail.discard
    flash[:success] = '検査詳細情報を削除しました。'
    redirect_to inspection_details_path
  end

  private

  def inspection_detail_params
    params
      .require(:inspection_detail)
      .permit(:formal_name, :abbreviation, inspection_sets: [])
      .yield_self do |p|
        # 検査セットIDの集合を InspetionSet オブジェクトの集合(ActiveRecord::Relation)へ変換して返す
        p.merge(
          inspection_sets:
            InspectionSet.where(id: p[:inspection_sets]).limit(p[:inspection_sets]&.size)
        )
      end
  end
end
