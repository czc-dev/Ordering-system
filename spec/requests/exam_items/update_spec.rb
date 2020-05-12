# frozen_string_literal: true

RSpec.describe 'ExamItems PATCH/PUT /exam_items/:id', type: :request, js: true do
  let(:exam_item_id) { ExamItem.all.sample.id }

  include_context :act_login_as_administrator

  subject { put exam_item_path(exam_item_id), params: params }

  context 'when request is valid' do
    let(:params) do
      { exam_item: { formal_name: 'Must present/updated', abbreviation: 'Optional/updated' } }
    end

    it 'updates new exam_item' do
      subject
      exam_item = ExamItem.find_by(id: exam_item_id)
      expect(exam_item.formal_name).to eq(params[:exam_item][:formal_name])
      expect(exam_item.abbreviation).to eq(params[:exam_item][:abbreviation])
    end

    it { is_expected.to redirect_to(exam_item_path(exam_item_id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      { exam_item: { formal_name: '' } }
    end

    it { is_expected.to render_template('edit') }
  end
end
