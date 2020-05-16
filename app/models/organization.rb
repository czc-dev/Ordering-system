class Organization < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept.order(:id) }

  # validations
  validates :name, presence: true

  # relations
  has_many :employees, dependent: :destroy
  has_many :patients,  dependent: :destroy
end
