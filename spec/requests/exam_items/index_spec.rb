# frozen_string_literal: true

RSpec.describe 'ExamItems GET /exam_items', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:administrator) }
  let(:params) { { page: 1 } }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  before { get exam_items_path, params: params }

  it 'can show all exam_items on first page' do
    expect(assigns[:exam_items]).to eq(ExamItem.page(params[:page]))
  end

  it { should render_template('index') }
end
