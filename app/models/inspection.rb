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
  before_save :amend_state

  # Declare validation
  validates :urgent, :canceled, :submitted, inclusion: { in: [true, false] }
  validates :status_id, presence: true

  # Declare relation
  belongs_to :order
  belongs_to :inspection_detail

  def status
    STATES[status_id]
  end

  def urgent?
    urgent
  end

  def canceled?
    canceled
  end

  def submitted?
    submitted
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

  def sample_to_s
    sample.blank? ? '未取得' : sample
  end

  def result_to_s
    result.blank? ? '未取得' : result
  end

  def appraisal_to_s
    appraisal.blank? ? '未取得' : appraisal
  end

  private

  def set_default
    self.urgent    ||= false
    self.canceled  ||= false
    self.submitted ||= false
    self.status_id ||= 0
    self.sample    ||= ''
    self.result    ||= ''
    self.appraisal ||= ''
  end

  def amend_state
    self.status_id =
      if    !appraisal.blank? then 5
      elsif !result.blank?    then 4
      elsif !sample.blank? && submitted?  then 3
      elsif !sample.blank? && !submitted? then 2
      elsif !booked_at.nil?   then 1
      else 0
      end
  end
end
