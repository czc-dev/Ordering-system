require 'rails_helper'

RSpec.describe Log, type: :model do
  # validation
  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:content) }

  # relation
  it { should belong_to(:employee) }
end
