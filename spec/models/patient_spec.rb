RSpec.describe Patient, type: :model do
  # relations
  it { should belong_to(:organization) }
  it { should have_many(:orders).dependent(:destroy) }

  # validations
  it { should validate_presence_of(:birth) }
  it { should validate_presence_of(:name) }
end
