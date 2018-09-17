# frozen_string_literal: true

class Patient < ApplicationRecord
  # Define constant
  GENDERS = { 0 => '他', 1 => '男', 2 => '女' }.freeze

  # Declare callback
  before_validation :set_default

  # Declare validation
  validates :age, :birth, :gender_id, :name, presence: true

  # Declare relations
  has_many :orders

  def gender
    GENDERS[gender_id]
  end

  private

  def set_default
    self.gender_id ||= 0
  end
end
