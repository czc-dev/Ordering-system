# frozen_string_literal: true

RSpec.describe 'ExamSets GET /exam_sets', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:params) { { page: 1 } }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get exam_sets_path }

  it 'can show all exam sets on first page' do
    expect(assigns[:exam_sets]).to eq(ExamSet.page(params[:page]))
  end

  it { should render_template('index') }
end
