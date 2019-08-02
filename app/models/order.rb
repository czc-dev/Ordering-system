# frozen_string_literal: true

class Order < ApplicationRecord
  has_paper_trail

  # constants
  STATES = { 0 => '未完了', 1 => '完了' }.freeze

  # callbacks
  before_validation :set_default

  # validations
  validates :canceled, inclusion: { in: [true, false] }
  validates :status_id, presence: true

  # relations
  belongs_to :patient
  has_many :inspections, dependent: :destroy

  scope :lists_recently_created, -> { all.where(canceled: false).includes(:patient).last(20) }

  def inspections_with_detail
    inspections.includes(:inspection_detail)
  end

  def inspections_only_active
    inspections_with_detail.where(canceled: false)
  end

  def status
    STATES[status_id]
  end

  def canceled?
    canceled
  end

  def may_result_at_to_s
    may_result_at ? may_result_at.to_formatted_s(:simple) : '未定'
  end

  private

  def set_default
    self.canceled  ||= false
    self.status_id ||= 0
  end
end
