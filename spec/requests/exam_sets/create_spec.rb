# frozen_string_literal: true

RSpec.describe 'ExamSets POST /exam_sets', type: :request, js: true do
  include_context :act_login_as_administrator

  subject { post exam_sets_path, params: params }

  context 'when request is valid' do
    let(:params) do
      { exam_set: { name: 'Must present' } }
    end

    it 'creates new exam_set' do
      subject
      expect(assigns[:exam_set]).to eq(ExamSet.last)
    end

    it { is_expected.to redirect_to(exam_sets_path) }
  end

  context 'when request is invalid' do
    let(:params) do
      { exam_set: { name: '' } }
    end

    it { is_expected.to render_template('new') }
  end

  context 'when require is specified relations to exam item' do
    let(:exam_item_counts) { 5 }
    let(:exam_item_ids) { ExamItem.all.sample(exam_item_counts).pluck(:id) }
    let(:params) do
      { exam_set: { name: 'Must present', exam_item_ids: exam_item_ids } }
    end

    it 'assigns relations to exam item for created exam set' do
      sql_on_combinations = 'SELECT * from combinations'

      # 'change' macther can be received block as '{}' not 'do/end'
      expect { subject }.to change {
        ActiveRecord::Base.connection.execute(sql_on_combinations).count
      }.by(exam_item_counts)
    end
  end
end
