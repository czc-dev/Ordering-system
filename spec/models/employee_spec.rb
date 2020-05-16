RSpec.describe Employee, type: :model do
  # create employee to verify uniqueness validation
  let!(:employee) { create(:employee) }

  # validation
  it { should validate_presence_of(:fullname) }
  it { should validate_uniqueness_of(:email) }

  # values
  it { should_not allow_value('ユーザー').for(:email) }
  it { should_not allow_value('user').for(:email) }
  it { should_not allow_value('user@').for(:email) }
  it { should_not allow_value('@example.com').for(:email) }

  it { should allow_value('user@example.com').for(:email) }
end
