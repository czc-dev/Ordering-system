class CreateLogService
  include ServiceHelper

  def initialize(employee_id:, order_id:, content:)
    @employee_id = employee_id
    @order_id    = order_id
    @content     = content
  end

  def call
    employee.logs.create!(order_id: order_id, content: content)
  end

  private

  attr_reader :employee_id, :order_id, :content

  def employee
    @employee ||= Employee.find(employee_id)
  end
end
