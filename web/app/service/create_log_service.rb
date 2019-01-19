class CreateLogService
  include ServiceHelper

  # resource can institute instance of Order or Inspection
  def initialize(log_type:, resource:, employee:)
    @log_type = log_type
    @resource = resource
    @employee = employee
  end

  def call
    employee.logs.create!(log_data)
  end

  private

  attr_reader :log_type, :resource, :employee

  def log_data
    case log_type
    when :order_created
      # resource must be order
      {
        order_id: @resource.id,
        content:  "作成 : 患者#{@resource.patient.name}に__を作成しました。"
      }
    when :order_updated
      # resource must be order
      {
        order_id: @resource.id,
        content:  "変更 : __を#{@resource.canceled? ? 'キャンセル' : '再予約'}しました。"
      }
    when :inspection_added
      # resource must be order
      {
        order_id: @resource.id,
        content:  '追加 : __に検査を追加しました。'
      }
    when :inspection_updated
      # resource must be inspection
      {
        order_id: @resource.order.id,
        content:  '変更 : __の検査を変更しました。'
      }
    end
  end
end
