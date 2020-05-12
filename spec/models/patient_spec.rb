RSpec.describe Patient, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  it { should validate_presence_of(:birth) }
  it { should validate_presence_of(:name) }
end
