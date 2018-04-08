require 'rails_helper'

RSpec.describe Brand, type: :model do
  let(:brand) { create :brand }

  subject { brand }

  it { should be_valid }
  it { should validate_presence_of :name }
end
