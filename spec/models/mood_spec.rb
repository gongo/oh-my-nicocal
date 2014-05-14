require 'spec_helper'

describe Mood do
  before do
    @mood = Mood.new(name: 'happiness', score: 10)
  end

  describe '#save' do
    subject { @mood }
    it { should be_valid }

    context 'when name is not present' do
      before { @mood.name = '' }
      it { should_not be_valid }
    end

    context 'when score is not present' do
      before { @mood.score = '' }
      it { should_not be_valid }
    end

    context 'when name is already taken' do
      before do
        mood_with_same_name = @mood.dup
        mood_with_same_name.name = @mood.name.upcase
        mood_with_same_name.save
      end

      it { should_not be_valid }
    end

    context 'when name is not numerically' do
      before { @mood.score = 'foo' }
      it { should_not be_valid }
    end
  end
end
