class Invitation < ApplicationRecord
  TOKEN_SIZE = 128

  # implement revoke by using Discard's soft delete
  include Discard::Model
  default_scope -> { kept.order(:id) }
  self.discard_column = :revoked_at

  # relations
  belongs_to :organization, optional: true

  # validations
  validates :token, uniqueness: true
end
