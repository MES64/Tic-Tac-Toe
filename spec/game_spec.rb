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

  describe '#find_current_player' do
    # Located in Public Script Method #play_turn
    # Incoming Query Message -> Test return value
    let(:board) { instance_double(Board) }
    let(:player_X) { instance_double(Player) }
    let(:player_O) { instance_double(Player) }

    context 'when it is player X turn' do
      subject(:game_current_X) { described_class.new(board:, players: [player_X, player_O], player_turn: 0) }

      it 'returns player X' do
        current_player = game_current_X.find_current_player
        expect(current_player).to be(player_X)
      end
    end

    context 'when it is player O turn' do
      subject(:game_current_O) { described_class.new(board:, players: [player_X, player_O], player_turn: 1) }

      it 'returns player O' do
        current_player = game_current_O.find_current_player
        expect(current_player).to be(player_O)
      end
    end
  end

  describe '#make_move' do
    # Located in Public Script Method #play_turn
    # Outgoing Command Message -> Test that a message is sent
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }
    subject(:game_make_move) { described_class.new(board:, players: [player, player]) }

    before do
      allow(game_make_move).to receive(:board).and_return(board)
      allow(player).to receive(:make_move)
    end

    it 'sends make_move message to player' do
      expect(player).to receive(:make_move).with(board).once
      game_make_move.make_move(player)
    end
  end

  describe '#check_game_over' do
    # Located in Public Script Method #play_turn
    # Incoming Command Message -> Test the change in the observable state
    # 4 Possibilities:
    # 1: No winner and board not full -> result = nil
    # 2: Winner and board not full -> result = winner_string
    # 3: No winner and board full -> result = draw_string
    # 4: Winner and board full -> result = winner_string

    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }

    before do
      allow(board).to receive(:board)
      allow(player).to receive(:token).and_return('X')
    end

    context 'when there is no winner and the board is not full' do
      subject(:game_result_nil) { described_class.new(board:, players: [player, player]) }

      before do
        allow(game_result_nil).to receive(:board).and_return(board)
        allow(player).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'leaves the result as nil' do
        game_result_nil.check_game_over(player)
        result = game_result_nil.result
        expect(result).to be_nil
      end
    end

    context 'when there is a winner and the board is not full' do
      subject(:game_result_winner) { described_class.new(board:, players: [player, player]) }

      before do
        allow(game_result_winner).to receive(:board).and_return(board)
        allow(player).to receive(:winner?).and_return(true)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'sets the result to the winner string' do
        game_result_winner.check_game_over(player)
        result = game_result_winner.result
        expect(result).to eql('Player X has won the game!')
      end
    end

    context 'when there is no winner and the board is full' do
      subject(:game_result_draw) { described_class.new(board:, players: [player, player]) }

      before do
        allow(game_result_draw).to receive(:board).and_return(board)
        allow(player).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it 'sets the result to the draw string' do
        game_result_draw.check_game_over(player)
        result = game_result_draw.result
        expect(result).to eql('Draw!')
      end
    end

    context 'when there is a winner and the board is full' do
      subject(:game_result_full_winner) { described_class.new(board:, players: [player, player]) }

      before do
        allow(game_result_full_winner).to receive(:board).and_return(board)
        allow(player).to receive(:winner?).and_return(true)
        allow(board).to receive(:full?).and_return(true)
      end

      it 'sets the result to the winner string' do
        game_result_full_winner.check_game_over(player)
        result = game_result_full_winner.result
        expect(result).to eql('Player X has won the game!')
      end
    end
  end
end
