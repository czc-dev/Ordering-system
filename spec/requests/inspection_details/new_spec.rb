# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /inspection_details/new', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  before { get new_inspection_details_path }

  it { should render_template('new') }
end
