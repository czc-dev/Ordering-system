require 'rails_helper'

RSpec.describe Inspection, type: :model do
  # validation
  it { should validate_precense_of(:status_id) }
  it { should validate_precense_of(:sample) }
  it { should validate_precense_of(:result) }

  # relation
  it { should belong_to(:order) }
  it { should belong_to(:inspection_detail) }
end
