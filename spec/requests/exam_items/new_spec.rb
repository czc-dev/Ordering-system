# frozen_string_literal: true

RSpec.describe 'ExamItems GET /exam_items/new', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:administrator) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  before { get new_exam_item_path }

  it 'can show list of inspection sets' do
    expect(assigns[:exam_sets]).to eq(ExamSet.all)
  end

  it { should render_template('new') }
end
