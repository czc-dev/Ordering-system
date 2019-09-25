# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /exam_sets/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:exam_set_id) { ExamSet.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get exam_set_path(exam_set_id) }

  it 'can show specific exam set' do
    expect(assigns[:exam_set]).to eq(ExamSet.find_by(id: exam_set_id))
  end

  it { should render_template('show') }
end
