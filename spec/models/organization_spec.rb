RSpec.describe Organization, type: :model do
  # relations
  it { should have_many(:employees).dependent(:destroy) }
  it { should have_many(:patients).dependent(:destroy) }

  # validations
  it { should validate_presence_of(:name) }

  # values
  it { should_not allow_value('').for(:name) }
end
