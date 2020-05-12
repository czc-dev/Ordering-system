# frozen_string_literal: true

RSpec.describe 'ExamSets GET /exam_sets/new', type: :request, js: true do
  include_context :act_login_as_administrator

  subject { get new_exam_set_path }

  it 'can show list of exam item' do
    subject
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it { is_expected.to render_template('new') }
end
