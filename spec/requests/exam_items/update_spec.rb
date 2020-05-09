# frozen_string_literal: true

RSpec.describe 'ExamItems PATCH/PUT /exam_items/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:employee, :administrator) }
  let(:exam_item_id) { ExamItem.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  context 'when request is valid' do
    let(:params) do
      { exam_item: { formal_name: 'Must present/updated', abbreviation: 'Optional/updated' } }
    end

    before { put exam_item_path(exam_item_id), params: params }

    it 'creates new exam_item' do
      # リダイレクト先のアクション 'show' にて最新のものを表示していること
      expect(assigns[:exam_item]).to eq(ExamItem.find_by(id: exam_item_id))
    end

    it { should redirect_to(exam_item_path(exam_item_id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      { exam_item: { formal_name: '' } }
    end

    before { put exam_item_path(exam_item_id), params: params }

    it { should render_template('edit') }
  end
end
