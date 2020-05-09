# frozen_string_literal: true

RSpec.describe 'ExamItems DELETE /exam_items/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administrator) { create(:administrator) }
  let(:exam_item_id) { ExamItem.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administrator.username, password: administrator.password } }

  before { delete exam_item_path(exam_item_id) }

  it 'deletes(discards) exam_item' do
    expect(ExamItem.with_discarded.find_by(id: exam_item_id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    expect(ExamItem.find_by(id: exam_item_id)).to be_nil
  end

  it { should redirect_to(exam_items_path) }
end
