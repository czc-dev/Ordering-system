# frozen_string_literal: true

class Employee < ApplicationRecord
  has_secure_password

  # validation
  validates_presence_of :fullname, :username
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 4, maximum: 64
  validates_format_of :username, with: /\A[a-zA-Z]\w+\z/

  # TODO: resource#paper_trail がないものを渡した時のエラーハンドリングを作成（する必要あるかも）
  def self.originator_of(resource)
    select(:fullname).find_by(id: resource.paper_trail.originator)&.fullname || 'Unknown-Employee'
  end
end
