# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  describe '#at' do
    # Incoming Query Message -> Test return value
    board = [['X', ' ', 'O'],
             [' ', ' ', 'X'],
             ['O', 'X', 'O']]
    subject(:board_at) { described_class.new(board) }

    context 'when the chosen coordinates are on the board' do
      it 'returns X for coordinates [0, 0]' do
        token = board_at.at([0, 0])
        expect(token).to eql('X')
      end

      it 'returns space for coordinates [1, 1]' do
        token = board_at.at([1, 1])
        expect(token).to eql(' ')
      end

      it 'returns O for coordinates [2, 2]' do
        token = board_at.at([2, 2])
        expect(token).to eql('O')
      end

      it 'returns O for coordinates [0, 2]' do
        token = board_at.at([0, 2])
        expect(token).to eql('O')
      end
    end

    context 'when the chosen coordinates are off the board' do
      it 'returns nil for coordinates [-1, -1]' do
        token = board_at.at([-1, -1])
        expect(token).to be_nil
      end

      it 'returns nil for coordinates [3, 3]' do
        token = board_at.at([3, 3])
        expect(token).to be_nil
      end

      it 'returns nil for coordinates [1, 3]' do
        token = board_at.at([1, 3])
        expect(token).to be_nil
      end
    end
  end
end
