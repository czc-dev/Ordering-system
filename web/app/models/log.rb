# frozen_string_literal: true

class Log < ApplicationRecord
  # validation
  validates_presence_of :order_id, :content

  # relation
  belongs_to :employee
end
