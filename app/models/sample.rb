# frozen_string_literal: true

class Sample < ApplicationRecord
  # Declare relation
  belongs_to :inspection

  # Declare validation
  validates :condition, presence: true
end
