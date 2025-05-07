# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

RSpec.describe Player do
  describe '#input_coords' do
    # Located in Public Script Method #make_move
    # Looping Script Method -> Test its behavior
    # It could be classified as an incoming query message but it has too much responsibility
    # in my opinion (follow the Single Responsibility Principle). Also, testing the return value
    # depends on lots of things that has/should already be tested, so it should be ignored since
    # the return value depends on these already-tested methods in the looping script method
    subject(:player_input) { described_class.new('X') }
    let(:board) { instance_double(Board) }

    before do
      allow(player_input).to receive(:puts)
      allow(player_input).to receive(:choose_coord).and_return(0)
    end

    context 'when coordinates chosen contains an empty space' do
      before { allow(board).to receive(:at).and_return(' ') }

      it 'does not display error message' do
        expect(player_input).to_not receive(:puts).with('Invalid Input: A token already exists there')
        player_input.input_coords(board)
      end
    end

    context 'when coordinates chosen contains a token, then an empty space' do
      before { allow(board).to receive(:at).and_return('O', ' ') }

      it 'displays error message exactly once' do
        expect(player_input).to receive(:puts).with('Invalid Input: A token already exists there').once
        player_input.input_coords(board)
      end
    end

    context 'when coordinates chosen contains a token 3 times in a row, then an empty space' do
      before { allow(board).to receive(:at).and_return('O', 'X', 'O', ' ') }

      it 'displays error message 3 times exactly' do
        expect(player_input).to receive(:puts).with('Invalid Input: A token already exists there').exactly(3).times
        player_input.input_coords(board)
      end
    end
  end
end
