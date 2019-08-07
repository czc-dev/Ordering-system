class PaperTrail::VersionsController < ApplicationController
  def index
    @orders = rencent_histories(item_type: 'Order')
    @inspections = rencent_histories(item_type: 'Inspection')
  end

  def show
    @history = PaperTrail::Version.find_by(id: params[:id])
    @version_author = Employee.find_by(id: @history.version_author)
  end

  private

  def rencent_histories(item_type:)
    PaperTrail::Version.where(item_type: item_type).order(created_at: :desc).first(10)
  end
end
