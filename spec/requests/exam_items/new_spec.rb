# frozen_string_literal: true

RSpec.describe 'ExamItems GET /exam_items/new', type: :request, js: true do
  include_context :act_login_as_administrator

  subject { get new_exam_item_path }

  it 'can show list of inspection sets' do
    subject
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it { is_expected.to render_template('new') }
end
