require 'rails_helper'

RSpec.describe Result, type: :model do
  it { should belong_to(:inspection) }
  it { should validate_presence_of(:content) }
end
