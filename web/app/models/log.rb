# frozen_string_literal: true

class Log < ApplicationRecord
  # validation
  validates_presence_of :order_id, :content

  # relation
  belongs_to :employee

  def to_render
    content.sub('__', "<a href=\"/orders/#{order_id}/inspections\">オーダー##{order_id}</a>").html_safe
  end
end
