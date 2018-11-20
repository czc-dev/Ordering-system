# frozen_string_literal: true

class Patient < ApplicationRecord
  # Define constant
  GENDERS = { 0 => '他', 1 => '男', 2 => '女' }.freeze

  # Declare callback
  after_initialize :set_default

  # Declare validation
  validates :age, :birth, :gender_id, :name, presence: true
  validates :age, inclusion: { in: 0..130 }
  validates :gender_id, inclusion: { in: 0..2 }

  # Declare relations
  has_many :orders, dependent: :destroy

  def gender
    GENDERS[gender_id]
  end

  private

  def set_default
    self.gender_id ||= 0
  end
end
