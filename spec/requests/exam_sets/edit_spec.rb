# frozen_string_literal: true

RSpec.describe 'ExamSets GET /exam_sets/:id/edit', type: :request, js: true do
  let(:exam_set_id) { ExamSet.all.sample.id }

  include_context :act_login_as_administrator

  before { get edit_exam_set_path(exam_set_id) }

  it 'can show specific exam_set' do
    expect(assigns[:exam_set]).to eq(ExamSet.find_by(id: exam_set_id))
  end

  it 'can show list of exam items' do
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it { should render_template('edit') }
end
