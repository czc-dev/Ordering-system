# frozen_string_literal: true

class Inspection < ApplicationRecord
  # Define constant
  STATES = {
    0 => '予約未',
    1 => '予約済',
    2 => '採取済',
    3 => '結果未',
    4 => '結果済',
    5 => '評価済'
  }.freeze

  # Declare callback
  before_validation :set_default

  # Declare validation
  validates :urgent, :cancelled, inclusion: { in: [true, false] }
  validates :status_id, presence: true

  # Declare relation
  belongs_to :order
  belongs_to :inspection_detail
  has_one :sample
  has_one :result

  def status
    STATES[status_id]
  end

  def cancelled?
    cancelled
  end

  def urgent?
    urgent
  end

  def formal_name
    inspection_detail.formal_name
  end

  def abbreviation
    inspection_detail.abbreviation
  end

  private

  def set_default
    self.urgent    ||= false
    self.cancelled ||= false
    self.status_id ||= 0
  end
end
