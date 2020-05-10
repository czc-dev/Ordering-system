# frozen_string_literal: true

RSpec.describe 'ExamItems GET /exam_items/new', type: :request, js: true do
  include_context :act_login_as_administrator

  before { get new_exam_item_path }

  it 'can show list of inspection sets' do
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it { should render_template('new') }
end
