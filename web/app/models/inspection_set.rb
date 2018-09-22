# frozen_string_literal: true

class InspectionSet < ApplicationRecord
  # Declare relation
  has_and_belongs_to_many :inspection_details, join_table: 'combinations'

  # Declare validation
  validates :set_name, presence: true
end
