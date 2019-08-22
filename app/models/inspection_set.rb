# frozen_string_literal: true

class InspectionSet < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept }

  has_paper_trail

  # Declare relation
  has_and_belongs_to_many :inspection_details, join_table: 'combinations'

  # Declare validation
  validates :set_name, presence: true
end
