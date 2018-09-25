require 'rails_helper'

RSpec.describe InspectionDetail, type: :model do
  it { should have_many(:inspections) }
  it { should validate_presence_of(:formal_name) }
end
