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

  # callbacks
  before_validation :generate_token

  def active?
    return true if expired_at.nil?

    expired_at.after?(Time.zone.now)
  end

  def revoke
    discard
  end

  def revoked?
    discarded?
  end

  def self.revoked
    with_discarded.discarded
  end

  def renew_for_newly_created_organization!(created_organization)
    new_token = SecureRandom.alphanumeric(TOKEN_SIZE)
    update!(organization: created_organization, token: new_token)
  end

  private

  def generate_token
    self.token ||= SecureRandom.alphanumeric(TOKEN_SIZE)
  end
end
