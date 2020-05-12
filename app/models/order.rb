# frozen_string_literal: true

class Order < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept.order(:id) }

  has_paper_trail

  enum status: %i[in_progress done]

  # callbacks
  after_discard do
    exams.update_all(discarded_at: discarded_at)
  end

  # validations
  validates :canceled, inclusion: { in: [true, false] }
  validates :status, presence: true

  # relations
  belongs_to :patient
  has_many :exams, dependent: :destroy

  scope :recently_created, -> { where(canceled: false).includes(:patient).last(20) }

  def exams_with_detail
    exams.includes(:exam_item)
  end

  def exams_only_active
    exams_with_detail.where(canceled: false)
  end

  def canceled?
    canceled
  end

  def may_result_at_to_s
    may_result_at ? may_result_at.to_formatted_s(:simple) : '未定'
  end
end
