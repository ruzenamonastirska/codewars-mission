# frozen_string_literal: true

require './user'

RSpec.describe User do
  let(:user) { User.new }
  describe '#initialize' do
    it 'sets the initial rank to -8' do
      expect(user.rank).to eq(-8)
    end

    it 'sets the initial progress to 0' do
      expect(user.progress).to eq(0)
    end
  end

  describe '#inc_progress' do
    context 'when activity is 2 lower than rank' do
      it 'ignores it' do
        user.rank = 8
        user.progress = 0
        user.inc_progress(6)
        expect(user.progress).to eq(0)
      end
    end

    context 'when activity is 1 lower thank rank' do
      it 'gives 1 point' do
        user.rank = 6
        user.progress = 0
        user.inc_progress(5)
        expect(user.progress).to eq(1)
      end
    end

    context 'when activity is same as rank' do
      it 'gives 3 points' do
        user.rank = -5
        user.progress = 50
        user.inc_progress(-5)
        expect(user.progress).to eq(53)
      end
    end

    context 'when activity is higher thank rank' do
      it 'adds progress with formula' do
        user.rank = -6
        user.progress = 0
        user.inc_progress(-4)
        expect(user.progress).to eq(40)
      end

      it 'updates the rank' do
        user.rank = 2
        user.progress = 80
        user.inc_progress(4)
        expect(user.progress).to eq(20)
        expect(user.rank).to eq(3)
      end

      it 'updates the rank 2 up' do
        user.rank = -8
        user.progress = 80
        user.inc_progress(-4)
        expect(user.progress).to eq(40)
        expect(user.rank).to eq(-6)
      end

      it 'calculates the diff between -1 and 1 to be 1' do
        user.rank = -1
        user.progress = 80
        user.inc_progress(1)
        expect(user.progress).to eq(90)
      end

      it 'skips rank 0' do
        user.rank = -1
        user.progress = 80
        user.inc_progress(2)
        expect(user.progress).to eq(20)
        expect(user.rank).to eq(1)
      end
    end

    context 'when activity rank is invalid' do
      it 'raises an error' do
        user.rank = 1
        user.progress = 0
        expect{user.inc_progress(10)}.to raise_error(StandardError)
      end
    end
  end
end
