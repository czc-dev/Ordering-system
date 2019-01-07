require 'rails_helper'

RSpec.describe Inspection, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:inspection_detail) }
end
