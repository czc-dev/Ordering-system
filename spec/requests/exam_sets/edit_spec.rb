# frozen_string_literal: true

RSpec.describe 'ExamSets GET /exam_sets/:id/edit', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:administrator) }
  let(:exam_set_id) { ExamSet.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  before { get edit_exam_set_path(exam_set_id) }

  it 'can show specific exam_set' do
    expect(assigns[:exam_set]).to eq(ExamSet.find_by(id: exam_set_id))
  end

  it 'can show list of exam items' do
    expect(assigns[:exam_items]).to eq(ExamItem.all)
  end

  it { should render_template('edit') }
end
