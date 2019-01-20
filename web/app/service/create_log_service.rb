class CreateLogService
  include ServiceHelper

  # 'resource' には Inspection か Order のインスタンスが代入されることを想定しています。
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
      # 'resource' は Order のインスタンスです
      {
        order_id: @resource.id,
        content:  "作成 : 患者#{@resource.patient.name}に__を作成しました。"
      }
    when :order_updated
      # 'resource' は Order のインスタンスです
      {
        order_id: @resource.id,
        content:  '変更 : __の状態を更新しました。'
      }
    when :inspection_added
      # 'resource' は Order のインスタンスです
      {
        order_id: @resource.id,
        content:  '追加 : __に検査を追加しました。'
      }
    when :inspection_updated
      # 'resource' は Inspection のインスタンスです
      {
        order_id: @resource.order.id,
        content:  '変更 : __の検査を変更しました。'
      }
    else
      raise UndefinedLogTypeError
    end
  end

  class UndefinedLogTypeError < StandardError; end
end
