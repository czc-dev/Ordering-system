# frozen_string_literal: true

class Employee < ApplicationRecord
  has_secure_password

  validates_presence_of :fullname, :username
  validates_uniqueness_of :username
end
