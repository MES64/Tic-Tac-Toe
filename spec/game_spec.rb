# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

RSpec.describe Game do
  describe '#game_loop' do
    # Located in Public Script Method #play
    # Looping Script -> Test behavior
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }
    subject(:game_main_loop) { described_class.new(board:, players: [player, player]) }

    before { allow(game_main_loop).to receive(:play_turn) }

    context 'when #result returns not nil initially' do
      before { allow(game_main_loop).to receive(:result).and_return('Game Over') }

      it 'does not enter loop and #play_turn message is not sent' do
        expect(game_main_loop).to_not receive(:play_turn)
        game_main_loop.game_loop
      end
    end

    context 'when #result returns [nil, not nil]' do
      before { allow(game_main_loop).to receive(:result).and_return(nil, 'Game Over') }

      it 'sends #play_turn message exactly once' do
        expect(game_main_loop).to receive(:play_turn).once
        game_main_loop.game_loop
      end
    end

    context 'when #result returns [nil, nil, nil, nil, not nil]' do
      before { allow(game_main_loop).to receive(:result).and_return(nil, nil, nil, nil, 'Game Over') }

      it 'sends #play_turn message exactly four times' do
        expect(game_main_loop).to receive(:play_turn).exactly(4).times
        game_main_loop.game_loop
      end
    end
  end
end
