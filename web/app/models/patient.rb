# frozen_string_literal: true

class Patient < ApplicationRecord
  # Define constant
  GENDERS = { 0 => '他', 1 => '男', 2 => '女' }.freeze

  # Declare callback
  after_initialize :set_default

  # Declare validation
  validates :birth, :gender_id, :name, presence: true
  validates :gender_id, inclusion: { in: 0..2 }

  # Declare relations
  has_many :orders, dependent: :destroy

  def gender
    GENDERS[gender_id]
  end

  # Calculate age from birthday with timezone Asia/Tokyo
  # Reference:
  #   https://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age
    dob = birth
    now = Time.zone.now
    self.age ||=
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  private

  def set_default
    self.gender_id ||= 0
  end
end
