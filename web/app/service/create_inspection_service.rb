class CreateInspectionService
  include ServiceHelper

  def initialize(order:, inspections:)
    @order = order
    @inspections = inspections
  end

  def call
    @inspections.each do |id|
      @order.inspections.create!(inspection_detail: InspectionDetail.find(id))
    end
  end
end
