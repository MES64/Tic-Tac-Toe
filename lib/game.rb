# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game holds info about the game state: board state, players, player turn, and result.
# It has methods for playing a turn and checking for game over
class Game
  attr_accessor :board, :players, :player_turn, :result

  def initialize(board: Board.new, players: [Player.new('X'), Player.new('O')], player_turn: 0, result: nil)
    @board = board
    @players = players
    @player_turn = player_turn
    @result = result
  end

  def play
    print_board
    game_loop
    puts result
  end

  def game_loop
    play_turn while result.nil?
  end

  def play_turn
    current_player = find_current_player
    make_move(current_player)
    check_game_over(current_player)
    switch_player_turn
    print_board
  end

  def find_current_player
    players[player_turn]
  end

  def make_move(current_player)
    current_player.make_move(board)
  end

  def check_game_over(current_player)
    # Only the player that has just moved can win the game
    return self.result = "Player #{current_player.token} has won the game!" if current_player.winner?(board.board)

    self.result = 'Draw!' if board.full?
  end

  def switch_player_turn
    self.player_turn = 1 - player_turn
  end

  def print_board
    board.print
  end
end
