RSpec.describe ExamItem, type: :model do
  it { should have_and_belong_to_many(:exam_sets) }
  it { should have_many(:exams) }
  it { should validate_presence_of(:formal_name) }
end
