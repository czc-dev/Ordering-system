# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ajax::SelectExamItems', type: :request, js: true do
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /ajax/select_exam_items/index' do
    context 'when params: exam_set_id not specified' do
      before { get ajax_select_exam_items_path }

      it { should render_template('index') }

      it 'can show all exam items' do
        expect(assigns[:exam_items]).to eq(ExamItem.all)
      end
    end

    context 'when params: exam_set_id specified' do
      let(:exam_set_id) { ExamSet.all.sample.id }
      before { get ajax_select_exam_items_path(exam_set_id: exam_set_id) }

      it { should render_template('index') }

      it 'can show related exam items' do
        expect(assigns[:exam_items]).to eq(ExamSet.find_by(id: exam_set_id).exam_items)
      end
    end
  end

  describe 'GET /ajax/select_exam_items/new' do
    let(:exam_item_ids) { ExamItem.all.sample(5).map(&:id) }
    before { get new_ajax_select_exam_item_path(exam_item_ids: exam_item_ids) }

    it { should render_template('new') }

    it 'can show selected exams' do
      expect(assigns[:exam_items]).to eq(ExamItem.where(id: exam_item_ids))
    end
  end
end
