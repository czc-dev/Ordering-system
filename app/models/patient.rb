# frozen_string_literal: true

class Patient < ApplicationRecord
  # implement soft delete
  include Discard::Model
  default_scope -> { kept }

  has_paper_trail

  # Define constant
  GENDERS = { 0 => '他', 1 => '男', 2 => '女' }.freeze

  # Declare callback
  after_initialize :set_default
  after_discard do
    orders.each { |order| order.inspections.update_all(discarded_at: discarded_at) }
    orders.update_all(discarded_at: discarded_at)
  end

  # Declare validation
  validates :birth, :gender_id, :name, presence: true
  validates :gender_id, inclusion: { in: 0..2 }

  # Declare relations
  has_many :orders, dependent: :destroy

  def orders_only_active
    orders.where(canceled: false)
  end

  def gender
    GENDERS[gender_id]
  end

  def age
    @age ||= calc_age
  end

  private

  def set_default
    self.gender_id ||= 0
  end

  def calc_age
    dob = birth
    now = Time.zone.now
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
