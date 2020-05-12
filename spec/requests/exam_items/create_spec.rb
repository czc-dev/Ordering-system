# frozen_string_literal: true

RSpec.describe 'ExamItems POST /exam_items', type: :request, js: true do
  include_context :act_login_as_administrator

  subject { post exam_items_path, params: params }

  context 'when request is valid' do
    let(:params) do
      { exam_item: { formal_name: 'Must present', abbreviation: 'Optional' } }
    end

    it 'creates new exam_item' do
      expect { subject }.to change { ExamItem.count }.by(1)
    end

    it { is_expected.to redirect_to(exam_items_path) }
  end

  context 'when request is invalid' do
    let(:params) do
      { exam_item: { formal_name: '' } }
    end

    it { is_expected.to render_template('new') }
  end

  context 'when require is specified relations to exam set' do
    let(:exam_set_counts) { 5 }
    let(:exam_set_ids) { ExamSet.all.sample(exam_set_counts).pluck(:id) }
    let(:params) do
      { exam_item: { formal_name: 'Must present', exam_set_ids: exam_set_ids } }
    end

    it 'assigns relations to exam sets for created exam detail' do
      sql_on_combinations = 'SELECT * from combinations'

      # 'change' macther can be received block as '{}' not 'do/end'
      expect { subject }.to change {
        ActiveRecord::Base.connection.execute(sql_on_combinations).count
      }.by(exam_set_counts)
    end
  end
end
