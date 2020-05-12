RSpec.describe Order, type: :model do
  it { should belong_to(:patient) }
  it { should have_many(:exams).dependent(:destroy) }
end
