require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:birth) }
  # `gender_id` is always set before validation
  # it { should validate_presence_of(:gender_id) }
  it { should validate_presence_of(:name) }
end
