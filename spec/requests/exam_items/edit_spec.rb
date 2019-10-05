# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExamItems GET /exam_items/:id/edit', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:exam_item_id) { ExamItem.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get edit_exam_item_path(exam_item_id) }

  it 'can show specific inspection detail' do
    expect(assigns[:exam_item]).to eq(ExamItem.find_by(id: exam_item_id))
  end

  it 'can show list of exam sets' do
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it { should render_template('edit') }
end
