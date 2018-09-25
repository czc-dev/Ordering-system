require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:patient) }
  it { should have_many(:inspections).dependent(:destroy) }
end
