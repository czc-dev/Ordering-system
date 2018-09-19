# frozen_string_literal: true

class Order < ApplicationRecord
  # Define constant
  STATES = { 0 => '未完了', 1 => '完了' }.freeze

  # Declare callback
  before_validation :set_default

  # Declare validation
  validates :cancelled, inclusion: { in: [true, false] }
  validates :status_id, presence: true

  # Declare relation
  belongs_to :patient
  has_many :inspections, dependent: :destroy

  def status
    STATES[status_id]
  end

  def cancelled?
    cancelled
  end

  private

  def set_default
    self.cancelled ||= false
    self.status_id ||= 0
  end
end
