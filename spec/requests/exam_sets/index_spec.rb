# frozen_string_literal: true

RSpec.describe 'ExamSets GET /exam_sets', type: :request, js: true do
  let(:params) { { page: 1 } }

  include_context :act_login_as_administrator

  subject { get exam_sets_path }

  it 'can show all exam sets on first page' do
    subject
    expect(assigns[:exam_sets]).to eq(ExamSet.page(params[:page]))
  end

  it { is_expected.to render_template('index') }
end
