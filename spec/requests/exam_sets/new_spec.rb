# frozen_string_literal: true

RSpec.describe 'ExamSets GET /exam_sets/new', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:administrator) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  before { get new_exam_set_path }

  it 'can show list of exam item' do
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it { should render_template('new') }
end
