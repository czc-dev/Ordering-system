# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExamSets POST /exam_sets', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when request is valid' do
    let(:params) do
      { exam_set: { set_name: 'Must present' } }
    end

    before { post exam_sets_path, params: params }

    it 'creates new exam_set' do
      # リダイレクト先のアクション 'show' にて最新のものを表示していること
      expect(assigns[:exam_set]).to eq(ExamSet.last)
    end

    it { should redirect_to(exam_set_path(ExamSet.last.id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      { exam_set: { set_name: '' } }
    end

    before { post exam_sets_path, params: params }

    it { should render_template('new') }
  end

  context 'when require is specified relations to exam item' do
    let(:detail_ids) { (1..5).to_a }
    let(:params) do
      { exam_set: { set_name: 'Must present', exam_items: detail_ids } }
    end

    before { post exam_sets_path, params: params }

    it 'assigns relations to exam item for created exam set' do
      assigned_details = ExamSet.last.inspection_details
      base_details     = ExamItem.where(id: detail_ids)
      expect((assigned_details & base_details).size).to eq(detail_ids.size)
    end
  end
end
