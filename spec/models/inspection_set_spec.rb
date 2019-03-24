require 'rails_helper'

RSpec.describe InspectionSet, type: :model do
  it { should have_and_belong_to_many(:inspection_details) }
  it { should validate_presence_of(:set_name) }
end
