# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExamItems GET /exam_items', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get exam_items_path }

  it 'can show all exam_items' do
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it { should render_template('index') }
end
