require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create :category }

  subject { category }

  it { should be_valid }
  it { should validate_presence_of :name }

  describe 'acts as a tree' do
    before do
      3.times do
        child = create(:category)
        subject.children << child

        grandchild = create(:category)
        child.children << grandchild
      end 
    end 

    describe '.root?' do
      it { expect(subject.root?).to be_truthy }
    end 

    describe 'has 3 children' do
      it { expect(subject.children.size).to eq 3 } 
    end 

    describe 'has 6 descendants' do
      it { expect(subject.descendants.size).to eq 6 } 
    end 

    describe 'child has 2 siblings' do
      let(:child) { subject.children.first }

      it { expect(child.siblings.size).to eq 2 } 
    end 
  end
end
