require 'rails_helper'

RSpec.describe Sample, type: :model do
  it { should belong_to(:inspection) }
  it { should validate_presence_of(:condition) }
end