class CreateLogService
  include ServiceHelper

  def initialize(log_type:, order:, employee:)
    @log_type = log_type
    @order    = order
    @employee = employee
  end

  def call
    employee.logs.create!(log_data)
  end

  private

  attr_reader :log_type, :order, :employee

  def log_data
    @log_data ||=
      case log_type
      when :order_created      then log_data_order_created
      when :order_updated      then log_data_order_updated
      when :inspection_added   then log_data_inspection_added
      when :inspection_updated then log_data_inspection_updated
      else raise UndefinedLogTypeError
      end

    @log_data.merge!(order_id: order.id)
  end

  def log_data_order_created
    { content:  "作成 : 患者#{order.patient.name}に__を作成しました。" }
  end

  def log_data_order_updated
    { content:  '変更 : __の状態を更新しました。' }
  end

  def log_data_inspection_added
    { content:  '追加 : __に検査を追加しました。' }
  end

  def log_data_inspection_updated
    { content:  '変更 : __の検査を変更しました。' }
  end

  class UndefinedLogTypeError < StandardError; end
end
