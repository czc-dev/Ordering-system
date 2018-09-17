# frozen_string_literal: true

class Result < ApplicationRecord
  # Declare relation
  belongs_to :inspection

  # Declare validation
  validates :content, presence: true
end
