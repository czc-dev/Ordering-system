class Organization < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept.order(:id) }

  # validations
  validates :name, presence: true
end
