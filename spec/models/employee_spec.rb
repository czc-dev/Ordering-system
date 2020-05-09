RSpec.describe Employee, type: :model do
  # validation
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:username).is_at_least(4) }
  it { should validate_length_of(:username).is_at_most(64) }

  it { should_not allow_value('ユーザー').for(:username) }
  it { should_not allow_value('userハロー').for(:username) }
  it { should_not allow_value('8anned_user').for(:username) }
  it { should_not allow_value('usr').for(:username) }
  it { should_not allow_value('user' * 17).for(:username) }
  it { should_not allow_value('user-name').for(:username) }
  it { should_not allow_value('user with white space').for(:username) }
  it { should allow_value('u2er_name').for(:username) }
  it { should allow_value('hellow0r1d').for(:username) }
end
