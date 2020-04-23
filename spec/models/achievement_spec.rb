require 'rails_helper'

RSpec.describe Achievement, type: :model do
  it { should have_many(:encouragements) }
end
