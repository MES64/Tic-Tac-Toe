# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  describe '#at' do
    # Incoming Query Message -> Test return value
    let(:board) do
      [['X', ' ', 'O'],
       [' ', ' ', 'X'],
       ['O', 'X', 'O']]
    end
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

  describe '#place_token' do
    # Incoming Command Message -> Test that board is updated correctly
    context 'when place O token over X token at [0, 0]' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_place_O) { described_class.new(board) }

      it 'updates X token with O token at [0, 0] only' do
        expected_board = [['O', ' ', 'O'],
                          [' ', ' ', 'X'],
                          ['O', 'X', 'O']]
        board_place_O.place_token('O', [0, 0])
        actual_board = board_place_O.board
        expect(actual_board).to eql(expected_board)
      end
    end

    context 'when place X token over empty space at [1, 1]' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_place_X) { described_class.new(board) }

      it 'updates space token with X token at [1, 1] only' do
        expected_board = [['X', ' ', 'O'],
                          [' ', 'X', 'X'],
                          ['O', 'X', 'O']]
        board_place_X.place_token('X', [1, 1])
        actual_board = board_place_X.board
        expect(actual_board).to eql(expected_board)
      end
    end

    context 'when place O token over O token at [2, 0]' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_place_same) { described_class.new(board) }

      it 'keeps the board unchanged' do
        expected_board = [['X', ' ', 'O'],
                          [' ', ' ', 'X'],
                          ['O', 'X', 'O']]
        board_place_same.place_token('O', [2, 0])
        actual_board = board_place_same.board
        expect(actual_board).to eql(expected_board)
      end
    end

    context 'when place X token off the board at [-1, -1]' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_place_negative) { described_class.new(board) }

      it 'keeps the board unchanged' do
        expected_board = [['X', ' ', 'O'],
                          [' ', ' ', 'X'],
                          ['O', 'X', 'O']]
        board_place_negative.place_token('X', [-1, -1])
        actual_board = board_place_negative.board
        expect(actual_board).to eql(expected_board)
      end
    end

    context 'when place O token off the board at [3, 3]' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_place_over_two) { described_class.new(board) }

      it 'keeps the board unchanged' do
        expected_board = [['X', ' ', 'O'],
                          [' ', ' ', 'X'],
                          ['O', 'X', 'O']]
        board_place_over_two.place_token('O', [3, 3])
        actual_board = board_place_over_two.board
        expect(actual_board).to eql(expected_board)
      end
    end

    context 'when place X token off the board at [0, -10]' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_place_mix) { described_class.new(board) }

      it 'keeps the board unchanged' do
        expected_board = [['X', ' ', 'O'],
                          [' ', ' ', 'X'],
                          ['O', 'X', 'O']]
        board_place_mix.place_token('X', [0, -10])
        actual_board = board_place_mix.board
        expect(actual_board).to eql(expected_board)
      end
    end
  end

  describe '#full?' do
    # Incoming Query Message -> Test the return value

    context 'when the board is empty' do
      let(:board_empty) do
        [[' ', ' ', ' '],
         [' ', ' ', ' '],
         [' ', ' ', ' ']]
      end
      subject(:board_full_empty) { described_class.new(board_empty) }

      it 'returns false' do
        expect(board_full_empty).to_not be_full
      end
    end

    context 'when the board has some tokens on but is not full' do
      let(:board) do
        [['X', ' ', 'O'],
         [' ', ' ', 'X'],
         ['O', 'X', 'O']]
      end
      subject(:board_full_half) { described_class.new(board) }

      it 'returns false' do
        expect(board_full_half).to_not be_full
      end
    end

    context 'when the board is full of tokens' do
      let(:board_full) do
        [%w[X X O],
         %w[O X X],
         %w[O X O]]
      end
      subject(:board_full_complete) { described_class.new(board_full) }

      it 'returns true' do
        expect(board_full_complete).to be_full
      end
    end
  end
end
