RSpec.describe Employee, type: :model do
  # validation
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  # values
  it { should_not allow_value('ユーザー').for(:email) }
  it { should_not allow_value('user').for(:email) }
  it { should_not allow_value('user@').for(:email) }
  it { should_not allow_value('@example.com').for(:email) }

  it { should allow_value('user@example.com').for(:email) }
end
