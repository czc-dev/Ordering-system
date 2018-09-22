# frozen_string_literal: true

class Order < ApplicationRecord
  # Define constant
  STATES = { 0 => '未完了', 1 => '完了' }.freeze

  # Declare callback
  before_validation :set_default

  # Declare validation
  validates :canceled, inclusion: { in: [true, false] }
  validates :status_id, presence: true

  # Declare relation
  belongs_to :patient
  has_many :inspections, dependent: :destroy

  def status
    STATES[status_id]
  end

  def canceled?
    canceled
  end

  private

  def set_default
    self.canceled  ||= false
    self.status_id ||= 0
  end
end
