# frozen_string_literal: true

RSpec.describe 'Ajax::SelectExamSets', type: :request, js: true do
  include_context :act_login_as_employee

  describe 'GET /ajax/select_exam_sets/new' do
    let(:exam_set_ids) { ExamSet.all.sample(5).map(&:id) }

    before { get new_ajax_select_exam_set_path(exam_set_ids: exam_set_ids) }

    it { should render_template('new') }

    it 'can show selected exams' do
      expect(assigns[:exam_sets]).to eq(ExamSet.where(id: exam_set_ids))
    end
  end
end
