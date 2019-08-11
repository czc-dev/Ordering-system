class PaperTrail::VersionsController < ApplicationController
  def index
    @patients    = rencent_histories(item_type: 'Patient', count: 5)
    @orders      = rencent_histories(item_type: 'Order')
    @inspections = rencent_histories(item_type: 'Inspection')
  end

  def show
    @history = PaperTrail::Version.find_by(id: params[:id])
    @version_author = Employee.with_discarded.find_by(id: @history.version_author)
  end

  private

  def rencent_histories(item_type:, count: 10)
    PaperTrail::Version.where(item_type: item_type).order(created_at: :desc).first(count)
  end
end
