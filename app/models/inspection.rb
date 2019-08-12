# frozen_string_literal: true

class Inspection < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept }

  has_paper_trail

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
  validates :urgent, :canceled, inclusion: { in: [true, false] }
  validates :status_id, presence: true

  # Declare relation
  belongs_to :order
  belongs_to :inspection_detail

  def status
    STATES[status_id]
  end

  def canceled?
    canceled
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

  def booked_at_to_s
    booked_at ? booked_at.to_formatted_s(:simple) : '未定'
  end

  private

  def set_default
    self.urgent    ||= false
    self.canceled  ||= false
    self.status_id ||= 0
    self.sample    ||= ''
    self.result    ||= ''
    self.appraisal ||= ''
  end
end
