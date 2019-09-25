require 'rails_helper'

RSpec.describe ExamItem, type: :model do
  it { should have_many(:exams) }
  it { should validate_presence_of(:formal_name) }
end
