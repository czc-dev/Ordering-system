RSpec.describe Exam, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:exam_item) }
end
