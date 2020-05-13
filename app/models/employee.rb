# frozen_string_literal: true

class Employee < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  authenticates_with_sorcery!

  # implement soft delete
  include Discard::Model
  default_scope -> { kept.order(:id) }

  # validation
  validates :fullname, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX, message: 'format is invalid' }
  validates :password,
            length: { minimum: 4 },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password,
            confirmation: true,
            length: { minimum: 4 },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }

  # TODO: resource#paper_trail がないものを渡した時のエラーハンドリングを作成（する必要あるかも）
  def self.originator_of(resource)
    select(:fullname).find_by(id: resource.paper_trail.originator)&.fullname || 'Unknown-Employee'
  end
end
