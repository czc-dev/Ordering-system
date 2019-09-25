# frozen_string_literal: true

class ExamItem < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept }

  has_paper_trail

  # Declare relation
  has_and_belongs_to_many :exam_sets, join_table: 'combinations'
  has_many :exams

  # Declare validation
  validates :formal_name, presence: true
end
