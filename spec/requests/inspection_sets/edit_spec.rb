# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /inspection_sets/:id/edit', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:inspection_set_id) { InspectionSet.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get edit_inspection_set_path(inspection_set_id) }

  it 'can show specific inspection set' do
    expect(assigns[:inspection_set]).to eq(InspectionSet.find_by(id: inspection_set_id))
  end

  it 'can show list of inspection sets' do
    expect(assigns[:inspection_details]).to eq(InspectionDetail.all)
  end

  it { should render_template('edit') }
end
