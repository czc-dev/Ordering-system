# frozen_string_literal: true

class Exam < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept.order(:id) }

  has_paper_trail

  enum status: %i[unbooked booked sampled unresulted resulted appraised]

  # Declare callback
  before_save :amend_status

  # Declare validation
  validates :urgent, :canceled, :submitted, inclusion: { in: [true, false] }
  validates :status, presence: true

  # Declare relation
  belongs_to :order
  belongs_to :exam_item

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
    exam_item.formal_name
  end

  def abbreviation
    exam_item.abbreviation
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

  def amend_status
    self.status =
      if    !appraisal.blank? then :appraised
      elsif !result.blank?    then :resulted
      elsif !sample.blank? &&  submitted? then :unresulted
      elsif !sample.blank? && !submitted? then :sampled
      elsif !booked_at.nil?   then :booked
      else :unbooked
      end
  end
end
