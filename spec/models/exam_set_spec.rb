RSpec.describe ExamSet, type: :model do
  it { should have_and_belong_to_many(:exam_items) }
  it { should validate_presence_of(:name) }
end
