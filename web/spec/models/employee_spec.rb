require 'rails_helper'

RSpec.describe Employee, type: :model do
  # validation
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  # relation
  it { should have_many(:logs) }
end
