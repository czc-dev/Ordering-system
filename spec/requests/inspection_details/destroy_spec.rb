# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /inspection_details/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:inspection_detail_id) { InspectionDetail.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { delete inspection_detail_path(inspection_detail_id) }

  it 'deletes(discards) inspection detail' do
    expect(InspectionDetail.with_discarded.find_by(id: inspection_detail_id).discarded?).to be_truthy
  end

  it 'cannot find by any resource because default_scope is set' do
    expect(InspectionDetail.find_by(id: inspection_detail_id)).to be_nil
  end

  it { should redirect_to(inspection_details_path) }
end
