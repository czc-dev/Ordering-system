# frozen_string_literal: true

class InspectionDetail < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept }

  has_paper_trail

  # Declare relation
  has_and_belongs_to_many :inspection_sets, join_table: 'combinations'
  has_many :inspections

  # Declare validation
  validates :formal_name, presence: true
end
