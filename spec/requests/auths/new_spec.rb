# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auths GET /login', type: :request, js: true do
  let!(:employee) { create(:employee) }
  let(:username) { employee.username }

  before { get login_path }
  it { should render_template('new') }
end
