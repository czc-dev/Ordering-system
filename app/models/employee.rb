# frozen_string_literal: true

class Employee < ApplicationRecord
  has_secure_password

  # validation
  validates_presence_of :fullname, :username
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 4, maximum: 64
  validates_format_of :username, with: /\A[a-zA-Z]\w+\z/

  # relation
  has_many :logs
end
