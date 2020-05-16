RSpec.describe Invitation, type: :model do
  # create invitation to verify uniqueness validation
  let!(:invitation) { create(:invitation) }

  # validations
  it { should validate_uniqueness_of(:token) }
end
