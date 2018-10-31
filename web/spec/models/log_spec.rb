require 'rails_helper'

RSpec.describe Log, type: :model do
  it { should validate_presence_of(:who) }
  it { should validate_presence_of(:done) }
end
