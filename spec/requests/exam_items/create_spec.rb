# frozen_string_literal: true

RSpec.describe 'ExamItems POST /exam_items', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when request is valid' do
    let(:params) do
      { exam_item: { formal_name: 'Must present', abbreviation: 'Optional' } }
    end

    before { post exam_items_path, params: params }

    it 'creates new exam_item' do
      # リダイレクト先のアクション 'show' にて最新のものを表示していること
      expect(assigns[:exam_item]).to eq(ExamItem.last)
    end

    it { should redirect_to(exam_items_path) }
  end

  context 'when request is invalid' do
    let(:params) do
      { exam_item: { formal_name: '' } }
    end

    before { post exam_items_path, params: params }

    it { should render_template('new') }
  end

  context 'when require is specified relations to exam set' do
    let(:exam_set_ids) { (1..5).to_a }
    let(:params) do
      { exam_item: { formal_name: 'Must present', exam_sets: exam_set_ids } }
    end

    before { post exam_items_path, params: params }

    it 'assigns relations to exam sets for created exam detail' do
      assigned_sets = ExamItem.last.exam_sets
      base_sets     = ExamSet.where(id: exam_set_ids)
      expect((assigned_sets & base_sets).size).to eq(exam_set_ids.size)
    end
  end
end
