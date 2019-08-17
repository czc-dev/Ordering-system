# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH/PUT /inspection_details/:id', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }
  let(:inspection_detail_id) { InspectionDetail.all.sample.id }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when request is valid' do
    let(:params) do
      { inspection_detail: { formal_name: 'Must present/updated', abbreviation: 'Optional/updated' } }
    end

    before { put inspection_detail_path(inspection_detail_id), params: params }

    it 'creates new inspection_detail' do
      # リダイレクト先のアクション 'show' にて最新のものを表示していること
      expect(assigns[:inspection_detail]).to eq(InspectionDetail.find_by(id: inspection_detail_id))
    end

    it { should redirect_to(inspection_detail_path(inspection_detail_id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      { inspection_detail: { formal_name: '' } }
    end

    before { put inspection_detail_path(inspection_detail_id), params: params }

    it { should render_template('edit') }
  end
end
