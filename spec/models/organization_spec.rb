RSpec.describe Organization, type: :model do
  # validations
  it { should validate_presence_of(:name) }

  # values
  it { should_not allow_value('').for(:name) }
end
