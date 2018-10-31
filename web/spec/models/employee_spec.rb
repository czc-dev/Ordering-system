require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  # it { should validate_presence_of(:password_digest) }
end
