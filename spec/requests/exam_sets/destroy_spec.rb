# frozen_string_literal: true

RSpec.describe 'ExamSets DELETE /exam_sets/:id', type: :request, js: true do
  let(:exam_set_id) { ExamSet.all.sample.id }

  include_context :act_login_as_administrator

  subject { delete exam_set_path(exam_set_id) }

  it 'deletes(discards) inspection set' do
    subject
    expect(ExamSet.with_discarded.find_by(id: exam_set_id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    subject
    expect(ExamSet.find_by(id: exam_set_id)).to be_nil
  end

  it { is_expected.to redirect_to(exam_sets_path) }
end
