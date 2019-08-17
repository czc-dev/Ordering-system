# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /inspection_details/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:inspection_detail_id) { InspectionDetail.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get inspection_detail_path(inspection_detail_id) }

  it 'can show specific inspection detail' do
    expect(assigns[:inspection_detail]).to eq(InspectionDetail.find_by(id: inspection_detail_id))
  end

  it { should render_template('show') }
end
